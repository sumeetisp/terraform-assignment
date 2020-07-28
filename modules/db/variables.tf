variable "db_subnets" {
	type = list
	default = ["subnet-3278787287","subnet-286372637"]
}

variable "db_storage" {
	type = number
	default = 20
}

variable "db_type" {
	type = string
	default = "gp2"
}

variable "db_type" {
	type = string
	default = "mysql"
}

variable "db_engine" {
	type = number
	default = 5.7
}

variable "db_name" {
	type = string
	default = "mysql"
}
