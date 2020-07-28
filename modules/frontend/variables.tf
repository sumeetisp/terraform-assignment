variable "cms_zones" {
    type    = list
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "cms_region" {
    type = string
    default = "us-east-1"
}

variable "cms_instance_size" {
    type = string
    default = "t2.micro"
}

variable "cms_images" {
    type = map
    default = {
        "us-east-1" = "ami-12345"
        "us-east-2" = "ami-34566"
        "us-west-1" = "ami-23267"
    }
}
