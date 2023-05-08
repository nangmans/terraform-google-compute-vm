#############
## General ## 
#############
create_template = false
project_id      = "gyeongsik-dev"
region          = "asia-northeast3"
instance_name   = "gce-demo-003"
labels = {
  "env" = "dev"
}
zone                      = "asia-northeast3-b" #기입시 Region + Zone으로 입력
allow_stopping_for_update = false
###########################
## Machine Configuration ##
###########################

machine_type = "e2-micro"
guest_accelerator = {
  count = 0
  type  = "nvdia-t4"
}
enable_display = false
#############################
## Confidential VM Service ##
#############################

confidential_instance_config = false

###########
## Disks ##
###########
boot_disk = {
  auto_delete             = true
  device_name             = "gyeongsik-dev"
  # disk_encryption_key_raw = "" #NULL
  image                   = "projects/centos-cloud/global/images/centos-7-v20221206"
  # kms_key_self_link       = ""
  kms_key_self_link       = "projects/gyeongsik-dev/locations/global/keyRings/gcp-kms-disk-key/cryptoKeys/gyeongsik-key-1"
  labels = {
    "env" = "dev"
  }
  size        = 30
  source      = ""
  source_type = "IMAGE"
  type        = "pd-ssd"
}
attached_disks_default = {
  auto_delete  = true
  mode         = "READ_WRITE"
  replica_zone = "asia-northeast3-c"
  type         = "pd-ssd"
}
attached_disks = [{
  device_name             = "attached-003"
  disk_encryption_key_raw = ""
  kms_key_self_link       = ""
  labels = {
    "env" = "dev"
  }
  options = {
    auto_delete  = true
    mode         = "READ_WRITE"
    replica_zone = null
    type         = "pd-ssd"
  }
  size   = 30
  source = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20221206"
  # source = "projects/centos-cloud/global/images/centos-7-v20221206"
  #image       =   #Usage Disk Images 
  source_type = "IMAGE"
  }]
#   {
#     device_name       = "attached-004"
#     kms_key_self_link = "projects/gyeongsik-dev/locations/global/keyRings/gcp-kms-disk-key/cryptoKeys/gyeongsik-key-1/cryptoKeyVersions/1"
#     # disk_encryption_key_raw = "CiQAsv4IxDgPlDpTzhdgemG8ic8h+uZUD++nU7XfwCBV/J5BLcoSPQDWz7jdlpaQIjOWbdhxcXv6Yy+h88H02iPPWuCAq1km0EmCmXwM/bfGml8amu080HoMBsJUi9stJi/Ftqo="
#     # disk_encryption_key_raw ="aGVsbG93b3JsZHNvdXRoa29yZWFoYWxvDQo="
#     kms_key_self_link = ""
#     # disk_encryption_key_raw = ""
#     # kms_key_self_link       = ""
#     # sha256 = "CiQAsv4IxDgPlDpTzhdgemG8ic8h+uZUD++nU7XfwCBV/J5BLcoSPQDWz7jdlpaQIjOWbdhxcXv6Yy+h88H02iPPWuCAq1km0EmCmXwM/bfGml8amu080HoMBsJUi9stJi/Ftqo="
#     region = "asia-northeast3"
#     labels = {
#       "env" = "dev"
#     }
#     options = {
#       auto_delete  = true
#       mode         = "READ_WRITE"
#       replica_zone = "asia-northeast3-c"
#       type         = "pd-ssd"
#     }
#     size   = 40
#     source = "projects/gyeongsik-dev/global/snapshots/demo-snapshot"
#     # image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20221206" #Usage Disk Images 
#     source_type = "SNAPSHOT"
#   }
# ]


#############################
## Identity and API access ##
#############################
service_account_create = false
service_account        = "gyeongsik-tf-svc@gyeongsik-dev.iam.gserviceaccount.com"
service_account_scopes = ["cloud-platform"]

################
## Networking ##
################ 
tags           = ["iapssh", "internal-ingress", "fw-dev-http"]
can_ip_forward = false
hostname       = ""
network_interface = [{
  address = {
    external_ip = "34.64.215.56"  # In the case of an external IP, if the IP address is allocated in GCP, it can be changed at any time.
    internal_ip =  null # Can be assigned when an instance is first created, cannot be assigned after it is created
  }
  # alias_ip_range = {
  #   "gyeongsik-dev" = "/29"
  # }
  nat                = true
  network            = "gyeongsik-dev"
  nic_type           = null
  stack_type         = "IPV4_ONLY"
  subnetwork         = "gyeongsik-dev"
  subnetwork_project = "gyeongsik-dev"
}]

##############
## Security ##
##############
shielded_instance_config = null

################
## Management ##
################

description                = "Demo Gyeongsik VM Create with attached Disks"
enable_deletion_protection = false
reservation_affinity       = null
metadata = {
  enable-oslogin     = true,
  enable-oslogin-2fa = true
}
# map('BusinessUnit','XYZ')
# scheduling_options = "STANDARD"


