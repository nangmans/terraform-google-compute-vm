# Simple Example

Compute VM Module을 사용하는 예시를 보여줍니다. 

## Usage

- simple_example Designated Directory에는 아래 작업이 구현되어 있습니다.
  - Instance 1EA 생성
  - Instance 옵션
    - 사설 IP, alias IP Range, 네트워크 태그, 라벨, 삭제 보호,metadata(OSLogin, OSLogin2fa) 등이 설정 되어 있음
    - Boot Disk(IMAGE) 
      - Boot Disk의 source_type을 IMAGE를 통해 배포되도록 설정 되어 있음
      - OS(CentOS 7)
    - Attached Disk(1)
      - Zoanl Disk이며, pd-ssd로 설정 되어 있음
    - Attached Disk(2)
      - Regional Disk이며, asia-northeast3-c Zone에 생성되도록 설정 되어 있음
      - Source Type은 SNAPSHOT으로 설정 되어 있음
    - Internal IP를 VPC 내에서 별도로 생성한 후 Static하게 설정 되어 있음
    - External IP는 Static하게 할당하여 외부와 통신이 가능하도록 설정 되어 있음
    - Machine Type은 e2-micro로 설정 되어 있음
    - Service Account의 경우, VM 생성시 Service Account가 생성되도록 설정 되어 있음
    - Access Scopes은 ["cloud-platform"]으로 설정 되어 있음
    - NVME Interface인 Local SSD가 설정 되어 있음

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_stopping\_for\_update | True면 Terraform이 인스턴스를 중지하여 해당 속성을 업데이트 하도록 허용 하는 옵션/해당 필드를 설정하지 않고 인스턴스를 중지해야 하는 속성을 업데이트 하려고 하면 업데이트가 실패함 | `bool` | `true` | no |
| attached\_disks | Attach disk의 속성값을 null값으로 등록한 경우, Attached_disk default값이 사용됨/원본 유형은 'IMAGE'(VM 및 템플릿의 영역 디스크), 'SNAPSHOT'(vm), 'EXISTING' 및 Null값 중 하나 선택 가능| <pre>list(object({<br>    device_name             = string ex) disk-{PROJECT_ID}-{VM_NAME}-{DEVICE_NAME}<br>    size                    = number ex) 20,30 ...<br>    labels                  = optional(map(string)) ex) labels = { "env" = "dev","module"="wnotify"}<br>    source                  = optional(string) ex) Source_Type에서 사용한 옵션의 Self_Link 혹은 Name('EXISTING'의 경우 이름만 기입) (이미지예시)source ="projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20221206"<br>    source_type             = optional(string) ex)"IMAGE","SNAPSHOT","EXISTING",null값 기입 가능 <br>    disk_encryption_key_raw = optional(string) ex) kms_key_self_link와 disk_encryption_key_raw중에 하나만 설정 가능 <br>    kms_key_self_link       = optional(string) ex) "projects/gyeongsik-dev/locations/global/keyRings/gcp-kms-disk-key/cryptoKeys/gyeongsik-key-1"Cloud KMS Self_Link(REST API에서 조회 필요)<br>    options = optional(<br>      object({<br>        auto_delete  = optional(bool, true)<br>        mode         = string ex) "READ_WRITE","READ","WRITE"<br>        type         = string ex) "pd-ssd","pd-balanced","pd-standard","pd-extreme"<br>        replica_zone = string ex) "asia-northeast3-{a,b,c}"<br>      }),<br>      {<br>        auto_delete  = true<br>        mode         = "READ_WRITE"<br>        replica_zone = null<br>        type         = "pd-balanced"<br>      }<br>    )<br><br>  }))</pre> | `[]` | no |
| attached\_disks\_default | Attached Disks의 Default 옵션 | <pre>object({<br>    auto_delete  = optional(bool, true)<br>    mode         = string ex) "READ","READ_WRITE","WRITE"<br>    type         = string ex) "pd-ssd","pd-extreme","pd-balanced","pd-standard"<br>    replica_zone = string ex) "asia-northeast3-b"<br>  })</pre> | <pre>{<br>  "auto_delete": true,<br>  "mode": "READ_WRITE",<br>  "replica_zone": null,<br>  "type": "pd-balanced"<br>}</pre> | no |
| boot\_disk | GCE(Compute Engine)의 부팅 디스크, Source Type("IMAGE","SNAPSHOT","EXISTING") 설정 가능   | <pre>object({<br>    source_type = optional(string) ex) IMAGE , SNAPSHOT , EXISTING<br>    source      = optional(string) ex)"SNAPSHOT" or "EXISTING" <br><br>    # For IMAGE<br>    image = optional(string, "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20221121") ex) Ubuntu 20.04 LTS x86/64<br><br>    # For IMAGE , SNAPSHOT  <br>    size   = optional(number, 10)<br>    type   = optional(string, "pd-balanced")<br>    labels = optional(map(string))<br><br>    disk_encryption_key_raw = optional(string) ex) kms_key_self_link 혹은 disk_encryption_key_raw 둘중에 하나만 설정 가능, <b>kms_key_self_link만 사용을 원할 경우, variables.tf에서 disk_encryption_key_raw 관련 variable 주석 설정 필요</b><br>    kms_key_self_link       = optional(string)<br><br>    auto_delete = optional(bool, true)<br>    device_name = optional(string) ex)disk-boot-{PROJECT_ID}-{GCE_NAME} <br>  })</pre> | n/a | yes |
| can\_ip\_forward | [다른 VM에서 시작된 패킷을 전달하는것을 허용하는 옵션](https://cloud.google.com/vpc/docs/using-routes#canipforward) | `bool` | `false` | no |
| confidential\_instance\_config | [기밀성 Booting을 활성화하는 옵션](https://cloud.google.com/compute/confidential-vm/docs/about-cvm) | `bool` | `false` | no |
| create\_template | instnace Template을 생성할지에 대한 옵션(<b>Instance Template은 EXISTING DISK를 붙일수가 없음/Instance Template은 현재 Regional Disk를 지원하지 않음 | `bool` | `false` | no |
| description | (중요)해당 리소스에 대한 설명  | `string` | `""` | no |
| enable\_deletion\_protection | GCE의 삭제 보호 설 | `bool` | `false` | no |
| enable\_display | [가상 디스플레이 활성화 옵션](https://cloud.google.com/compute/docs/instances/enable-instance-virtual-display#verify_display_driver) | `bool` | `false` | no |
| guest\_accelerator | GCE의 가속기 및 GPU 타입 설정 | <pre>object({<br>    type  = string<br>    count = number<br>  })</pre> | <pre>{<br>  "count": 0,<br>  "type": "nvidia-tesla-k80"<br>}</pre> | no |
| hostname | 인스턴스의 Host이름 FQDN(Fully Qualified Domain Name)이름과 RFC-1035에 유효해야함 (String) | `string` | `""` | no |
| instance\_name | (중요)생성하고자 하는 인스턴스의 이름(ex: vm-{environment}-{name}) | `string` | n/a | yes |
| labels | Compute Engine의 라벨 (ex: "env"="dev") | `map(string)` | `{}` | no |
| machine\_type | Machine Type 옵션 (ex: e2-micro, n1-standard-4) | `string` | n/a | yes |
| metadata | [GCE의 Metadata 설정](https://cloud.google.com/compute/docs/metadata/default-metadata-values) (ex: "enable-oslogin" = true)  | `map(string)` | `{}` | no |
| network\_interface | GCE의 Network Interface(External, Interanl IP) | <pre>list(object({<br>    nat                = optional(bool, false)<br>    network            = optional(string) ex) vpc_name "gyeongsik-dev"<br>    subnetwork         = optional(string) ex) vpc_subnet_name "gyeongsik-dev-subnet" <br>    subnetwork_project = optional(string) ex) subnetwork_projectid "gyeongsik-dev-prj"<br>    address = optional(object({<br>      internal_ip = string ex) 예약한 IP주소의 주소값 (ex: "192.168.20.5")<br>      external_ip = string ex) 에약한 IP주소의 주소값 (ex: "35.178.28.5")<br>    }), null)<br>    alias_ip_range = optional(map(string), {}) ex) {"subnetwork_range_name" = 10.172.0.0/24" " }<br>    nic_type       = optional(string) ex) "GVNIC" or "VIRTIO_NET"<br>    stack_type     = optional(string) ex) "IPV4_ONLY" <br>  }))</pre> | n/a | yes |
| project\_id | GCP Project ID ex) "prj-devops-sandbox" | `string` | n/a | yes |
| region | GCP Region  | `string` | `"asia-northeast3"` | no |
| reservation\_affinity | [인스턴스의 사용에 대해서 예약을 지정, 대규모 시스템에 적합한 옵션](https://cloud.google.com/compute/docs/instances/reserving-zonal-resources) | <pre>object({<br>    type = string                            ex) ANY_RESERVATION , SPECIFIC_RESERVATION , NO_RESERVATION<br>    specific_reservation = optional(object({ ex) {"compute.googleapis.com/reservation-name" = "name of reservation"}<br>      key    = string<br>      values = list(string)<br>    }))<br>  })</pre> | `null` | no |
| scheduling\_options | 인스턴스 스케줄링 옵션/[Live Migration](https://cloud.google.com/compute/docs/instances/live-migration-process) 여부 확인/provisioning model에 따라서 MIGRATE 옵션을 선택 가능/SPOT VM은 실행되는 동안 VM이 이벤트가 있을때 자동으로 다시 시작되도록 설정 불가능 (SPOT은 STOP만 가능) | <pre>object({<br>    provisioning_model          = optional(string, "STANDARD") ex) "STANDARD" or "SPOT"<br>    instance_termination_action = optional(string) ex) STOP, DELETE<br>  })</pre> | <pre>{<br>  "instance_termination_action": "",<br>  "provisioning_model": "STANDARD"<br>}</pre> | no |
| scratch\_disk | GCP에서 제공하는 물리 디스크/Interface("NVME", "SCSI")둘중에 하나를 지정해서 사용 가능/ Count 형태로 Local SSD 추가 생성 가능| <pre>object({<br>    count = number<br>    interface = string ex) "NVME" or "SCSI"<br>  })</pre> | <pre>{<br>  "count": 0,<br>  "interface": "NVME"<br>}</pre> | no |
| service\_account | Service Account를 지정하는 변수/사용하지 않을 경우 service_account_create variable을 통해 Service Account를 생성됨  | `string` | `null` | no |
| service\_account\_create | Service Account의 생성 유/무를 판단해주는 옵션  | `bool` | `false` | no |
| service\_account\_scopes | [GCE Access Scope](https://cloud.google.com/compute/docs/access/service-accounts?&_ga=2.148370807.-1554764575.1670140601#default_scopes)/권장사항은 cloud-platoform을 기입하도록 권고 ex) default = ["cloud-platform"]  | `list(string)` | <pre>[<br>  "cloud-platform"<br>]</pre> | no |
| shielded\_instance\_config | VM의 보안 부팅을 위한 옵션/무결성 모니터링 및 [vTPM(Virtual Trusted Platform Module)](https://cloud.google.com/compute/shielded-vm/docs/shielded-vm#vtpm) 신중한 부팅 옵션도 제공   | <pre>object({<br>    enable_secure_boot          = optional(bool)<br>    enable_vtpm                 = optional(bool)<br>    enable_integrity_monitoring = optional(bool)<br>  })</pre> | `null` | no |
| startup\_script | GCE의 [Startup Script](https://cloud.google.com/compute/docs/instances/startup-scripts/linux)/Bash Script 기반 변수 | `string` | `""` | no |
| tags | GCE의 Firewall Tags설정 ex) ["iapssh","http-80"] | `list(string)` | `[]` | no |
| zone | GCE의 Zone ex) "asia-northeast3-a" | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| external\_ip | VM의 External IP(임시 IP, Static IP) |
| instance | VM 이름 및 정보에 대한 Output |
| internal\_ip | Instance에 할당된 사설 IP |
| self\_link | Compute Instance의 Self_Link값 출력  |
| service\_account | Terraform을 통해 생성된 Service Account의 정보 |
| service\_account\_email | VM에 Attached된 Service Account |
| service\_account\_iam\_email | "serviceaccount:SERVICE_ACCOUNT@PROJECT_ID.iam.gserviceaccount.com" 형태 출력 |
| template | Instance Template에 대한 정보 출력 |
| template\_name | Instance Template Name |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
