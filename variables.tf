variable "vpc_cidrblock" {
  type = string
}
variable "vpc_enablednshostname" {
  type = bool
}
variable "vpc_enablednssupport" {
  type = bool
}
variable "vpc_name" {
  type = string
}
variable "subnets_availabilityzones" {
  type = list(string)
}
variable "subnets_cidrblocks" {
  type = list(string)
}
variable "subnet_mappubliciponlaunch" {
  type = bool
}