resource "google_compute_instance_template" "instance_template" {

  #############
  ## General ## 
  #############

  count       = var.create_template ? 1 : 0
  project     = var.project_id
  name_prefix = "${var.instance_name}-"
  labels      = var.labels
  region      = var.region

  ###########################
  ## Machine Configuration ##
  ###########################

  machine_type = var.machine_type
  guest_accelerator {
    type  = var.guest_accelerator.type
    count = var.guest_accelerator.count
  }
  

  #############################
  ## Confidential VM Service ##
  #############################

  dynamic "confidential_instance_config" {
    for_each = var.confidential_instance_config ? [""] : []
    content {
      enable_confidential_compute = true
    }
  }

  ###########
  ## Disks ##
  ###########

  disk { # MIG는 디스크 사이즈 변경시 인스턴스 재생성 방지가 의미 없으므로 기존 IMAGE boot disk 사용
    auto_delete  = var.boot_disk.auto_delete
    boot         = true
    device_name  = var.boot_disk.device_name
    source_image = var.boot_disk.source
    disk_type    = var.boot_disk.type
    disk_size_gb = var.boot_disk.size
  }

  dynamic "disk" {
    for_each = var.attached_disks
    iterator = config
    content {
      auto_delete  = config.value.options.auto_delete
      boot         = false
      device_name  = config.value.device_name
      source_image = config.value.source_type == "IMAGE" ? config.value.source : null
      source       = config.value.source_type == "EXISTING" ? config.value.source : null
      disk_type    = config.value.source_type != "EXISTING" ? config.value.options.type : null
      disk_size_gb = config.value.source_type != "EXISTING" ? config.value.size : null
      mode         = config.value.options.mode
    }
  }

  dynamic "disk" {
    for_each = [
      for i in range(var.scratch_disk.count) : var.scratch_disk.interface
    ]    
    iterator = config
    content {
      disk_type = "local-ssd"
      type = "SCRATCH"
      disk_size_gb = "375"
      interface = config.value
    }
  }



  #############################
  ## Identity and API access ##
  #############################

  service_account {
    email  = local.service_account_email
    scopes = var.service_account_scopes
  }

  ################
  ## Networking ##
  ################ 

  tags           = var.tags
  can_ip_forward = var.can_ip_forward
  # network_performance_config 
  dynamic "network_interface" {
    for_each = var.network_interface
    iterator = config
    content {
      network            = config.value.network
      subnetwork         = config.value.subnetwork
      subnetwork_project = config.value.subnetwork_project
      network_ip         = try(config.value.address.internal_ip, null)
      dynamic "access_config" {
        for_each = config.value.nat ? [""] : []
        content {
          nat_ip = try(config.value.address.external_ip, null)
        }
      }
      dynamic "alias_ip_range" {
        for_each = config.value.alias_ip_range
        iterator = config_alias
        content {
          subnetwork_range_name = config_alias.key
          ip_cidr_range         = config_alias.value
        }
      }
      nic_type   = config.value.nic_type
      stack_type = config.value.stack_type
    }
  }

  ##############
  ## Security ##
  ##############

  dynamic "shielded_instance_config" {
    for_each = var.shielded_instance_config != null ? [var.shielded_instance_config] : []
    iterator = config
    content {
      enable_secure_boot          = config.value.enable_secure_boot
      enable_vtpm                 = config.value.enable_vtpm
      enable_integrity_monitoring = config.value.enable_integrity_monitoring
    }
  }

  ################
  ## Management ##
  ################

  description = var.description

  # reservation_affinity {
  #   type = var.reservation_affinity.type
  #   specific_reservation {
  #     key = var.reservation_affinity.specific_reservation.key
  #     values = var.reservation_affinity.specific_reservation.values
  #   }
  # }

  dynamic "reservation_affinity" { # attribute 자체에 optional한 속성을 부여하고 싶다면 dynamic block의 for_each에 empty list를 활용하는 방법을 사용한다.
    for_each = var.reservation_affinity != null ? [""] : []
    content {
      type = var.reservation_affinity.type
      specific_reservation {
        key    = var.reservation_affinity.specific_reservation.key
        values = var.reservation_affinity.specific_reservation.values
      }
    }
  }

  metadata_startup_script = var.startup_script

  metadata = var.metadata

  scheduling {
    automatic_restart           = local.automatic_restart
    preemptible                 = local.preemptible
    on_host_maintenance         = local.on_host_maintenance
    provisioning_model          = var.scheduling_options.provisioning_model
    instance_termination_action = local.instance_termination_action
  }
}