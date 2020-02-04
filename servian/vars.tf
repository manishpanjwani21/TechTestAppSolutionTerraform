variable "AWS_ACCESS_KEY" {
default="PLEASE ADD HERE"   
}

variable "AWS_SECRET_KEY" {
 default="PLEASE ADD HERE" 

}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "PLEASE ADD HERE"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "PLEASE ADD HERE"
}

variable "NameOfKey"{
  default = "ReviseAWS"
}
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-062f7200baf2fa504"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "DBUSER" {
  type = string
  default = "postgres1"
}

variable "DBNAME" {
  type = string
  default = "testtechdb1"
}

variable "DBPASS" {
  type = string
  default = "Testing123!"
}

variable "S3BUCKET" {
  type = string
  default = "PLEASE ADD HERE"
  
}
