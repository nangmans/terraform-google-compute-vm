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
allow_stopping_for_update = false
###########################
## Machine Configuration ##
###########################

machine_type = "n1-standard-4"
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
  device_name             = "gyeongsik-dev-1"
  disk_encryption_key_raw = null
  image                   = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20221206"
  kms_key_self_link       = null
  # kms_key_self_link = "projects/gyeongsik-dev/locations/global/keyRings/gcp-kms-disk-key/cryptoKeys/gyeongsik-key-1/cryptoKeyVersions/1"
  labels = {
    "env" = "dev"
  }
  size        = 20
  source      = null
  source_type = null 
  type        = "pd-ssd"
}
scratch_disk = {
  count = 1
  interface = "NVME"
}
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
hostname       = ""
network_interface = [{
  address = {
    external_ip = null # In the case of an external IP, if the IP address is allocated in GCP, it can be changed at any time.
    internal_ip = null # Can be assigned when an instance is first created, cannot be assigned after it is created
  }
  alias_ip_range = {
    "gyeongsik-dev" = "/29"
  }
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
metadata = {
  enable-oslogin     = true,
  enable-oslogin-2fa = true
}
# map('BusinessUnit','XYZ')
startup_script = "echo gyeongsik man > /test.txt"

scheduling_options = {
  provisioning_model = "STANDARD"
  instance_termination_action = "DELETE"
}