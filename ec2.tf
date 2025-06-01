data "template_file" "app1" {
    template = file("${path.module}/scripts/app1.sh") 
}

data "template_file" "app2" {
    template = file("${path.module}/scripts/app2.sh") 
}

resource "aws_instance" "instance_app1" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.lab10_subnet_az1.id
    vpc_security_group_ids = [aws_security_group.lab10_ec2_sg.id]
    key_name = var.key_name
    user_data = data.template_file.app1.rendered
    tags = {
        Name = "${var.project_name}-app1"
    }
}

resource "aws_instance" "instance_app2" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.lab10_subnet_az2.id
    vpc_security_group_ids = [aws_security_group.lab10_ec2_sg.id]
    key_name = var.key_name
    user_data = data.template_file.app2.rendered
    tags = {
        Name = "${var.project_name}-app2"
    }
}