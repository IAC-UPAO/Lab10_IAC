# Laboratorio 10: Balanceador de Carga AWS con Terraform

Este proyecto implementa una infraestructura en AWS utilizando Terraform que despliega un sistema de balanceo de carga con distribución de tráfico 70/30 entre dos aplicaciones.

## Arquitectura

La infraestructura incluye:
- VPC con 2 subredes en diferentes zonas de disponibilidad
- Application Load Balancer (ALB)
- 2 instancias EC2 con diferentes aplicaciones
- Grupos de seguridad para ALB y EC2
- Configuración de balanceo de tráfico 70/30

## Configuración del Balanceador de Carga

El balanceo de carga se implementa usando un Application Load Balancer (ALB) de AWS. La configuración clave incluye:

### Listener y Reglas de Balanceo
```hcl
resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.lab10_alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      forward {
        target_group {
          arn = aws_lb_target_group.app1_tg.arn
          weight = 70  # 70% del tráfico
        }
        target_group {
          arn = aws_lb_target_group.app2_tg.arn
          weight = 30  # 30% del tráfico
        }
      }
    }
}
```

### Configuración de Health Checks
```hcl
health_check {
    enabled = true
    interval = 30           # Intervalo de chequeo en segundos
    path = "/"             # Ruta a verificar
    port = "traffic-port"  # Puerto a verificar
    timeout = 5            # Tiempo de espera en segundos
    healthy_threshold = 2   # Número de chequeos exitosos para considerar healthy
    unhealthy_threshold = 2 # Número de chequeos fallidos para considerar unhealthy
    matcher = "200"        # Código HTTP esperado
}
```

### Características del ALB
- **Tipo**: Application Load Balancer
- **Acceso**: Público (no interno)
- **Distribución**: 70% al servicio principal, 30% al secundario
- **Health Checks**: Cada 30 segundos en la ruta "/"
- **Protocolo**: HTTP en puerto 80
- **Alta Disponibilidad**: Desplegado en dos zonas de disponibilidad

## Capturas de Pantalla

### Aplicación 1 (70% del tráfico)
Detalles aplicación 1:
![Aplicación 1](img/app1.png)

Vista en Firefox:
![Aplicación 1 en Firefox](img/app1-firefox.png)

### Aplicación 2 (30% del tráfico)
Detalles aplicación 2:
![Aplicación 2](img/app2.png)

Vista en Firefox:
![Aplicación 2 en Firefox](img/app2-firefox.png)

### Infraestructura AWS
Vista de las instancias en la Consola AWS:
![Consola AWS](img/consola-instancias-aws.png)

## Prerrequisitos

- Terraform v1.0.0 o superior
- AWS CLI configurado con credenciales válidas
- Par de claves AWS (Key Pair) creado

## Configuración de Variables

1. Edite `terraform.tfvars` y configure los valores según su entorno:
- `aws_region`: Región de AWS donde se desplegarán los recursos
- `project_name`: Nombre base para identificar los recursos
- `key_name`: Nombre de su par de claves AWS
- `ami_id`: ID de la AMI que desea utilizar
- Otros valores según necesite personalizar

## Estructura del Proyecto

```
.
├── main.tf                 # Configuración principal de Terraform
├── variables.tf            # Definición de variables
├── network.tf              # Configuración de VPC y networking
├── security_groups.tf      # Grupos de seguridad
├── ec2.tf                 # Configuración de instancias EC2
├── alb.tf                 # Configuración del Application Load Balancer
├── outputs.tf             # Outputs del proyecto
├── terraform.tfvars.example # Ejemplo de variables
├── scripts/               # Scripts de inicialización
│   ├── app1.sh           # Script para la primera aplicación
│   └── app2.sh           # Script para la segunda aplicación
└── README.md             # Este archivo
```

## Despliegue

1. Inicializar Terraform:
```bash
terraform init
```

2. Revisar el plan de ejecución:
```bash
terraform plan
```

3. Aplicar la configuración:
```bash
terraform apply
```

4. Para destruir la infraestructura:
```bash
terraform destroy
```

## Outputs

Después del despliegue, Terraform mostrará:
- URL del balanceador de carga
- IPs públicas de las instancias EC2

## Configuración del Balanceo

El balanceador está configurado para distribuir el tráfico:
- 70% hacia la aplicación 1
- 30% hacia la aplicación 2

## Seguridad

Los grupos de seguridad están configurados para:
- ALB: Acepta tráfico HTTP (80) desde cualquier origen
- EC2: Acepta tráfico HTTP (80) solo desde el ALB



