variable "AWS_ACCESS_KEY" {
default="PLEASE ADD HERE"   
}

variable "AWS_SECRET_KEY" {
 default="PLEASE ADD HERE" 

}

variable "AWS_REGION" {
  default = "us-east-1"
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