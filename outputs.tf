output "alb_dns_name" {
    description = "Nombre dns del load balancer"
    value = aws_lb.lab10_alb.dns_name
}

output "app1_instance_public_ip" {
    description = "IP pública de la instancia app1"
    value = aws_instance.instance_app1.public_ip
}

output "app2_instance_public_ip" {
    description = "IP pública de la instancia app2"
    value = aws_instance.instance_app2.public_ip
}