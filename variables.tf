variable "aws_region" {
    description = "La región de aws donde se crearán los recursos"
    type = string
}

variable "project_name" {
    description = "Nombre base para los recursos del proyecto"
    type = string
}

variable "vpc_cidr" {
    description = "Rango de direcciones IP para la VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_az1_cidr" {
  description = "Rango de direcciones IP para la subnet en la AZ1"
  type = string
}

variable "subnet_az2_cidr" {
  description = "Rango de direcciones IP para la subnet en la AZ2"
  type = string
}

variable "availability_zone1" {
  description = "Nombre de la disponibilidad de la AZ1"
  type = string
}

variable "availability_zone2" {
  description = "Nombre de la disponibilidad de la AZ2"
  type = string
}

variable "instance_type" {
  description = "Tipo de instancia"
  type = string
  default = "t2.micro"
}

variable "ami_id" {
  description = "ID de la AMI para las instancias EC2"
  type = string
}

variable "key_name" {
  description = "Nombre de la clave SSH para las instancias EC2"
  type = string
}

variable "ip_for_ssh" {
  description = "IP desde la que se permitirá el acceso SSH a las instancias EC2"
  type = string
  default = "0.0.0.0/0"
}
