#############
## General ## 
#############
create_template = true
project_id      = "gyeongsik-dev"
region          = "asia-northeast3"
instance_name   = "gce-demo-004"
labels = {
  "env" = "dev"
}
zone                      = "asia-northeast3-a" #기입시 Region + Zone으로 입력
allow_stopping_for_update = true
###########################
## Machine Configuration ##
###########################

machine_type = "e2-micro"
enable_display = false
#############################
## Confidential VM Service ##
#############################

confidential_instance_config = false

###########
## Disks ##
###########
# Instance Template은 EXISTING DISK를 붙일수가 없음!
# Initialize Params를 사용하게 했음. 
# Instance Template은 현재 Regional Disk를 지원하지 않음
boot_disk = {
  auto_delete             = true
  device_name             = "gyeongsik-dev-1"
  # disk_encryption_key_raw = null
  image                   = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20221206"
  # kms_key_self_link       = null
  kms_key_self_link = "projects/gyeongsik-dev/locations/global/keyRings/gcp-kms-disk-key/cryptoKeys/gyeongsik-key-1"
  labels = {
    "env" = "dev"
  }
  size        = 20
  source      = null
  source_type = "IMAGE"
  type        = "pd-ssd"
}
attached_disks = [{
  device_name             = "attached-003"
  # disk_encryption_key_raw = ""
  kms_key_self_link       = "projects/gyeongsik-dev/locations/global/keyRings/gcp-kms-disk-key/cryptoKeys/gyeongsik-key-1"
  # kms_key_self_link       = ""
  labels = {
    "env" = "dev"
  }
  options = {
    auto_delete  = true
    mode         = "READ_WRITE"
    replica_zone = null
    type         = "pd-ssd"
  }
  size   = 20
  source = "projects/gyeongsik-dev/global/snapshots/demo-snapshot"
  #image       =   #Usage Disk Images 
  source_type = "SNAPSHOT"
}]

# attached_disks_default = {
#   auto_delete  = true
#   mode         = "READ_WRITE"
#   replica_zone = null
#   type         = "pd-ssd"
# }
#############################
## Identity and API access ##
#############################
service_account_create = true
# service_account        = "gyeongsik-tf-svc@gyeongsik-dev.iam.gserviceaccount.com"
service_account_scopes = ["cloud-platform"]

################
## Networking ##
################ 
tags           = ["iapssh", "internal-ingress", "fw-dev-http"]
can_ip_forward = false
hostname       = null
network_interface = [{
  address = {
    external_ip = null
    internal_ip = null
  }
  # alias_ip_range = {
  #   "gyeongsik-dev" = "/29"
  # }
  nat                = false
  network            = "gyeongsik-dev"
  nic_type           = null
  stack_type         = "IPV4_ONLY"
  subnetwork         = "gyeongsik-dev"
  subnetwork_project = "gyeongsik-dev"
}]

##############
## Security ##
##############
# shielded_instance_config = null
shielded_instance_config = {
  enable_integrity_monitoring = true
  enable_secure_boot = true 
  enable_vtpm = true
}

################
## Management ##
################

description                = "Demo Gyeongsik VM Create with attached Disks"
enable_deletion_protection = false
metadata = {
  enable-oslogin     = "true",
  enable-oslogin-2fa = "true"
}
startup_script = "echo gyeongsikman >> /test/test.txt"
# map('BusinessUnit','XYZ')