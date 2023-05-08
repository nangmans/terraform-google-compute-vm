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
zone                      = "asia-northeast3-a" #기입시 Region + Zone으로 입력
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
  auto_delete = true
  device_name = "gyeongsik-dev"
  # disk_encryption_key_raw = null
  image = "projects/centos-cloud/global/images/centos-7-v20221206"
  # kms_key_self_link       = ""
  # kms_key_self_link       = "projects/gyeongsik-dev/locations/global/keyRings/gcp-kms-disk-key/cryptoKeys/gyeongsik-key-1/cryptoKeyVersions/1"
  labels = {
    "env" = "dev"
  }
  size        = 20
  source      = ""      #EXSITING: 기존에 존재하는 Disk Name, SNAPSHOT: Soure type에 SNAPSHOT 적고 스냅샷 이름, Image: source(blank), source_type(image)
  source_type = "IMAGE" #Source Type Test
  type        = "pd-ssd"
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
    external_ip = "34.64.215.56" # In the case of an external IP, if the IP address is allocated in GCP, it can be changed at any time.
    internal_ip = "192.168.20.5" # Can be assigned when an instance is first created, cannot be assigned after it is created
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

# map('BusinessUnit','XYZ')
metadata = {
  enable-oslogin     = true,
  enable-oslogin-2fa = true
}


