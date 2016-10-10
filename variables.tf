variable "name" {
  default = "tf-waf-ip-filter-demo"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "ip_set" {
  default = {
    name  = "tf-waf-ip-filter"
    type  = "IPV4"
    value = "_YOUR_IP_"
  }
}

variable "cf_config" {
  default = {
    price_class = "PriceClass_200"
  }
}
