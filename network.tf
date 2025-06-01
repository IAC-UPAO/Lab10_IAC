resource "aws_vpc" "lab10_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "${var.project_name}-vpc"
    }
}

resource "aws_internet_gateway" "lab10_igw" {
    vpc_id = aws_vpc.lab10_vpc.id
    tags = {
        Name = "${var.project_name}-igw"
    }
}

resource "aws_subnet" "lab10_subnet_az1" {
    vpc_id = aws_vpc.lab10_vpc.id
    cidr_block = var.subnet_az1_cidr
    availability_zone = var.availability_zone1
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.project_name}-subnet-az1"
    }
}

resource "aws_subnet" "lab10_subnet_az2" {
    vpc_id = aws_vpc.lab10_vpc.id
    cidr_block = var.subnet_az2_cidr
    availability_zone = var.availability_zone2
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.project_name}-subnet-az2"
    }
}

resource "aws_route_table" "lab10_route_table" {
    vpc_id = aws_vpc.lab10_vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.lab10_igw.id
    }
    
    tags = {
        Name = "${var.project_name}-route-table"
    }
}

resource "aws_route_table_association" "subnet_az1_association" {
    subnet_id = aws_subnet.lab10_subnet_az1.id
    route_table_id = aws_route_table.lab10_route_table.id  
}

resource "aws_route_table_association" "subnet_az2_association" {
    subnet_id = aws_subnet.lab10_subnet_az2.id
    route_table_id = aws_route_table.lab10_route_table.id
}
