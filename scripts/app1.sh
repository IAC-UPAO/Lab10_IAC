#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Bienvenido al Servidor 1(70% del tráfico)</h1><p>Desplegado con Terraform</p>" | sudo tee /var/www/html/index.html
