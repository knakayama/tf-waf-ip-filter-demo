module "waf_ip_filter" {
  source = "github.com/knakayama/tf-waf-ip-filter"

  stack_name = "${var.name}"
  ip_set     = "${var.ip_set}"
}
