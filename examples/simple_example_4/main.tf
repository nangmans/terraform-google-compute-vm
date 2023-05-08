# Instance 1EA Verify
## Private IP, Net-Tags,Labels, Enable Delete Protection, Boot_Disk(1), Custom Metadata Settings
# Service Account Create
# External IP Check! Nat is Ephermeral IP, If you want a static IP, set the nat value to false and write the array value in the external IP
# Private Interanl IP Check!
# Disk Encryption Key Success!
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
  guest_accelerator = var.guest_accelerator
  enable_display    = var.enable_display
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
  description    = var.description
  startup_script = var.startup_script
  metadata = var.metadata
  scratch_disk = var.scratch_disk
}
