# Instance_Template 1EA Verify
# Net-Tags,Labels, Boot_Disk(1), Custom Metadata Settings, Labels
# boot_disk(IMAGE, SNAPSHOT, Blank Disk)
# Instance template does not support regional disks & Existing Disks.
# Service Account Create Success!
module "compute_vm" {
  source = "../../"

  #############
  ## General ## 
  #############
  create_template        = var.create_template
  service_account_create = var.service_account_create
  service_account        = var.service_account
  service_account_scopes = var.service_account_scopes
  project_id             = var.project_id
  instance_name          = var.instance_name
  labels                 = var.labels
  region                 = var.region
  zone                   = var.zone

  ###########################
  ## Machine Configuration ## 
  ###########################
  network_interface = var.network_interface
  tags              = var.tags
  hostname          = var.hostname
  can_ip_forward    = var.can_ip_forward
  machine_type      = var.machine_type
  enable_display = var.enable_display

  #############################
  ## Confidential VM Service ##
  #############################
  confidential_instance_config = var.confidential_instance_config
  enable_deletion_protection   = var.enable_deletion_protection

  ###########
  ## Disks ##
  ###########
  boot_disk              = var.boot_disk
  attached_disks         = var.attached_disks
  attached_disks_default = var.attached_disks_default

  ################
  ## Management ##
  ################
  description = var.description
  metadata    = var.metadata
  startup_script = var.startup_script
  scheduling_options = var.scheduling_options
}
