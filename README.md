# 📝 Proyecto final para el Bootcamp de DevOps (Código Facilito) - Final project for DevOps Bootcamp (Codigo Facilito)

### Backend !

## Description
En el presente proyecto se desarrolla la infraestructura automatizada, mediante Terraform y Ansible.
Se utiliza
Se realiza el despliegue del ciclo completo CI/CD de 3 aplicaciones:
* Proyecto 1: [Avatares-DevOps](https://gitlab.com/cf-devops-gsmx64-final/avatares-devops) (Backend Python 3.10 y Frontend React/Vite)
* Proyecto 2: [Todo-List-DevOps](https://gitlab.com/cf-devops-gsmx64-final/todo-list-devops) (Backend NodeJS con Frontend React Redux)
* Proyecto 3: [CF-Blog](https://github.com/gsmx64/cf-jsbackend-blog) (Backend NestJS y Frontend React/Vite)


### Infraestructura

![](https://raw.githubusercontent.com/gsmx64/cf-devops/main/docs/cf-devops-infraestructure.png)

Hay un servidor principal llamado main1, desde donde se corre:
* Motor de base de datos MySQL 8.0 (para el entorno de testing y producción),
* Motor de bases de datos PostgreSQL 15 (para el entorno de testing y producción),
* Jenkins para los pipelines,
* Sonarqube para el análisis de calidad de código,
* Las pruebas de Unittesting de cada parte (sea backend o frontend) para el entorno de testing,
* OWASP plugin para el análisis de seguridad,
* Docker Engine para el armado de las imágenes de entornos development y producción que luego serán
subidos a dockerhub,
* El ejecutable de Trivy para la verificación de vulnerabilidades de imágenes en docker.

Y Cluster de Kubernetes con un servidor master y 3 nodos workers (que por costos del proyecto solo es 1 master,
pero lo ideal serían 3 para lograr quorum y algunos workers más, y dejar por fuera la etcd).
Para el tema de la observabilidad o “monitoring” tengo corriendo en k8s prometheus (con alertmanager
configurado) y grafana, cada uno dentro del namespace monitoring.


## Docker y Kubernetes
Cada uno de los proyectos cuenta con su respectivo docker compose, uno para enviroment de development, uno para build de producción (se sube luego a Docker Hub), otro igual a este último pero que integra base de datos en el mismo docker compose, y el último es un simple docker compose que descarga las últimas versiones (latest) para su uso en producción (sistemas docker engine que se utilizan para este fin en lugar de kubernetes).
Por otro lado, se presentan los manifiestos funcionales para despliegue en un cluster de Kubernetes (K8S) para entornos cloud o bien baremetal.



## License
Este proyecto está licenciado con [GPL-3.0-1](https://github.com/gsmx64/cf-jsbackend-blog?tab=GPL-3.0-1-ov-file#readme).