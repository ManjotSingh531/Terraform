variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "ap-south-1"
}
variable "SecurityGroup" {
    default = ["sg-03e6a051495baff2b", "sg-0b2f243cf09cc5d2f"]
}