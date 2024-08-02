# 📝 Proyecto final para el Bootcamp de DevOps (Código Facilito) - Final project for DevOps Bootcamp (Codigo Facilito)

English translation not available for now.

## Description
En el presente proyecto se desarrolla la infraestructura automatizada, mediante Terraform y Ansible.
Se utiliza
Se realiza el despliegue del ciclo completo CI/CD de 3 aplicaciones:
* Proyecto 1: [Avatares-DevOps](https://gitlab.com/cf-devops-gsmx64-final/avatares-devops) (Backend Python 3.10 y Frontend React/Vite)
* Proyecto 2: [Todo-List-DevOps](https://gitlab.com/cf-devops-gsmx64-final/todo-list-devops) (Backend NodeJS con Frontend React Redux)
* Proyecto 3: [CF-Blog](https://github.com/gsmx64/cf-jsbackend-blog) (Backend NestJS y Frontend React/Vite)


## Infraestructura

![](https://raw.githubusercontent.com/gsmx64/cf-devops/main/docs/cf-devops-infraestructure.png)

Hay un servidor principal llamado "main1", desde donde se corre:
* Motor de base de datos MySQL 8.0 (para el entorno de testing y production),
* Motor de bases de datos PostgreSQL 15 (para el entorno de testing y production),
* Jenkins para los pipelines,
* Sonarqube para el análisis de calidad de código,
* Las pruebas de Unittesting de cada parte (sea backend o frontend) para el entorno de testing,
* OWASP plugin para el análisis de seguridad,
* Docker Engine para el armado de las imágenes de entornos development y production que luego serán
subidos a dockerhub,
* El ejecutable de Trivy para la verificación de vulnerabilidades de imágenes en docker.

Y Cluster de Kubernetes con un servidor master y 3 nodos workers (que por costos del proyecto solo es 1 master,
pero lo ideal serían 3 para lograr quorum y algunos workers más, y dejar por fuera la etcd).

Para el tema de la observabilidad o “monitoring” tengo corriendo en k8s las métricas con prometheus (con alertmanager
configurado) y grafana para los dashboards, cada uno dentro del namespace monitoring.

## IMPORTANTE!!!
![](https://raw.githubusercontent.com/gsmx64/cf-devops/main/docs/gcp-firewall-rules.jpg)
Requiere el armado de 3 reglas de firewall previo al despliegue (en GCP en mi caso, y se llaman tags):
* "ssh-enabled" (inicialmente era solo el Puerto del ssh, pero sume todos los puertos necesarios para que
estén accesibles a mi ip pública de mi servicio de internet, como si fuesen que están habilitados para su
acceso desde la red interna de una empresa),
* "cluster-internal-enabled" (puertos habilitados entre las máquinas virtuales main1 y las del clúster de
k8s),
* "cluster-external-enabled" (aquí estarían los puertos publicados al exterior, solamente los de los sitios
web en https -tcp 443)
Y los scripts para la instalación en el equipo local son para Ubuntu.

## Docker y Kubernetes
Cada uno de los proyectos cuenta con su respectivo docker compose, uno para enviroment de development, uno para build de producción (se sube luego a Docker Hub), otro igual a este último pero que integra base de datos en el mismo docker compose, y el último es un simple docker compose que descarga las últimas versiones (latest) para su uso en producción (sistemas docker engine que se utilizan para este fin en lugar de kubernetes).

Por otro lado, se presentan los manifiestos funcionales para despliegue en un cluster de Kubernetes (K8S) para entornos cloud o bien baremetal.

## Docker Hub
Aunque recomiendo utilizar los docker compose que hay en cada repositorio de cada proyecto, también se pueden bajar las imágenes development o prodduction desde [Docker Hub - GSMx64 Repository](https://hub.docker.com/repositories/gsmx64).

## Capturas de Jenkins, Sonarqube y Traefik
![](https://raw.githubusercontent.com/gsmx64/cf-devops/main/docs/jenkis-pipelines.jpg)
![](https://raw.githubusercontent.com/gsmx64/cf-devops/main/docs/sonarqube-code-quality.jpg)
![](https://raw.githubusercontent.com/gsmx64/cf-devops/main/docs/traefik-reverse-proxy-on-baremetal-cluster.jpg)

## Capturas de los proyectos desplegados en Kubernetes
![](https://raw.githubusercontent.com/gsmx64/cf-devops/main/docs/project-avatares-devops.jpg)
![](https://raw.githubusercontent.com/gsmx64/cf-devops/main/docs/project-todo-list-devops.jpg)
![](https://raw.githubusercontent.com/gsmx64/cf-devops/main/docs/project-cf-blog.jpg)

## Descarga del PDF descriptivo del proyecto
(Próximamente luego de presentarlo, y que se de la baja del cluster, se hará público)

## License
Este proyecto está licenciado con [GPL-3.0-1](https://github.com/gsmx64/cf-jsbackend-blog?tab=GPL-3.0-1-ov-file#readme).