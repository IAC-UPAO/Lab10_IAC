resource "aws_security_group" "lab10_alb_sg" {
    name = "${var.project_name}-alb-sg"
    description = "Grupo de seguridad para el ALB"
    vpc_id = aws_vpc.lab10_vpc.id

    ingress {
        description = "HTTP desde cualquier IP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Permitir todo el trafico de salida"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.project_name}-alb-sg"
    }
}

resource "aws_security_group" "lab10_ec2_sg" {
    name = "${var.project_name}-ec2-sg"
    description = "Grupo de seguridad para las instancias EC2"
    vpc_id = aws_vpc.lab10_vpc.id

    ingress {
        description = "Permitir trafico HTTP desde el ALB"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Permitir todo el trafico de salida"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.project_name}-ec2-sg"
    }
}