# 🐳 Dockerización de la Aplicación Web de Cumpleaños

Esta guía te explica cómo dockerizar y ejecutar la aplicación web de cumpleaños de Tina usando Docker.

## 📋 Prerrequisitos

Antes de comenzar, asegúrate de tener instalado:

- [Docker](https://docs.docker.com/get-docker/) (versión 20.10 o superior)
- [Docker Compose](https://docs.docker.com/compose/install/) (versión 2.0 o superior)

### Verificar instalación

```bash
docker --version
docker-compose --version
```

## 🚀 Comandos Básicos de Docker

### 1. Construir la imagen

```bash
# Construir la imagen desde el Dockerfile
docker build -t perritos-malvados .

# Construir con un tag específico
docker build -t perritos-malvados:v1.0 .
```

### 2. Ejecutar el contenedor

```bash
# Ejecutar en modo interactivo
docker run -d -p 8080:80 --name perritos-web perritos-malvados

# Ejecutar con reinicio automático
docker run -d -p 8080:80 --restart unless-stopped --name perritos-web perritos-malvados
```

### 3. Comandos útiles

```bash
# Ver contenedores en ejecución
docker ps

# Ver todos los contenedores (incluyendo detenidos)
docker ps -a

# Ver logs del contenedor
docker logs perritos-web

# Detener el contenedor
docker stop perritos-web

# Eliminar el contenedor
docker rm perritos-web

# Eliminar la imagen
docker rmi perritos-malvados
```

## 🐙 Usando Docker Compose

Docker Compose es más fácil para manejar aplicaciones complejas:

### Ejecutar la aplicación

```bash
# Construir y ejecutar
docker-compose up --build

# Ejecutar en segundo plano
docker-compose up -d

# Ejecutar solo el servicio web
docker-compose up web
```

### Comandos de Docker Compose

```bash
# Ver servicios en ejecución
docker-compose ps

# Ver logs
docker-compose logs

# Detener servicios
docker-compose down

# Detener y eliminar volúmenes
docker-compose down -v

# Reconstruir servicios
docker-compose up --build
```

## 🌐 Acceder a la Aplicación

Una vez que el contenedor esté ejecutándose:

- **Página principal**: http://localhost:8080
- **Página de invitación**: http://localhost:8080/invitacion.html

## 🔧 Configuración Avanzada

### Variables de Entorno

Puedes personalizar la aplicación usando variables de entorno:

```bash
docker run -d -p 8080:80 \
  -e NGINX_HOST=mi-servidor.com \
  -e NGINX_PORT=80 \
  --name perritos-web \
  perritos-malvados
```

### Volúmenes

Para persistir logs o datos:

```bash
docker run -d -p 8080:80 \
  -v $(pwd)/logs:/var/log/nginx \
  --name perritos-web \
  perritos-malvados
```

### Redes Personalizadas

```bash
# Crear una red personalizada
docker network create perritos-network

# Ejecutar contenedor en la red
docker run -d -p 8080:80 \
  --network perritos-network \
  --name perritos-web \
  perritos-malvados
```

## 🏭 Despliegue en Producción

### 1. Usar Docker Compose con perfil de producción

```bash
# Ejecutar con proxy nginx
docker-compose --profile production up -d
```

### 2. Usar un registro de contenedores

```bash
# Etiquetar para Docker Hub
docker tag perritos-malvados tu-usuario/perritos-malvados:v1.0

# Subir a Docker Hub
docker push tu-usuario/perritos-malvados:v1.0

# Ejecutar desde Docker Hub
docker run -d -p 8080:80 tu-usuario/perritos-malvados:v1.0
```

### 3. Usar Docker Swarm (para múltiples servidores)

```bash
# Inicializar swarm
docker swarm init

# Desplegar stack
docker stack deploy -c docker-compose.yml perritos-stack
```

## 🐛 Solución de Problemas

### Problemas Comunes

1. **Puerto ya en uso**:
   ```bash
   # Cambiar puerto
   docker run -d -p 8081:80 --name perritos-web perritos-malvados
   ```

2. **Contenedor no inicia**:
   ```bash
   # Ver logs
   docker logs perritos-web
   
   # Ejecutar en modo interactivo para debug
   docker run -it perritos-malvados /bin/sh
   ```

3. **Imagen no se construye**:
   ```bash
   # Construir sin cache
   docker build --no-cache -t perritos-malvados .
   ```

### Comandos de Limpieza

```bash
# Limpiar contenedores detenidos
docker container prune

# Limpiar imágenes no utilizadas
docker image prune

# Limpiar todo (¡CUIDADO!)
docker system prune -a
```

## 📊 Monitoreo

### Health Checks

La aplicación incluye health checks automáticos:

```bash
# Ver estado de salud
docker inspect --format='{{.State.Health.Status}}' perritos-web
```

### Métricas

```bash
# Ver uso de recursos
docker stats perritos-web

# Ver información detallada
docker inspect perritos-web
```

## 🎯 Mejores Prácticas

1. **Usar imágenes base pequeñas**: Alpine Linux es más ligero
2. **Multi-stage builds**: Para aplicaciones complejas
3. **No ejecutar como root**: Por seguridad
4. **Usar .dockerignore**: Para excluir archivos innecesarios
5. **Etiquetar versiones**: Para control de versiones
6. **Health checks**: Para monitoreo automático

## 🎉 ¡Feliz Dockerización!

¡Tu aplicación web de cumpleaños ahora está dockerizada y lista para ejecutarse en cualquier lugar! 🐕✨

---

*Para más información sobre Docker, visita: [https://docs.docker.com/](https://docs.docker.com/)*
