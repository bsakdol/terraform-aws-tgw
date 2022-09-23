################################################################################
## TRANSIT GATEWAY                                                            ##
################################################################################
output "tgw_all" {
  description = "A map of TGW attributes."
  value       = module.useast2.tgw_all
}
