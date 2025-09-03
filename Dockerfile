# Usar la imagen oficial de Nginx como base
FROM nginx:alpine

# Etiquetas para documentación
LABEL maintainer="Tu Nombre <tu.email@ejemplo.com>"
LABEL description="Aplicación web de cumpleaños de Tina"
LABEL version="1.0"

# Copiar los archivos de la aplicación al directorio de Nginx
COPY index.html /usr/share/nginx/html/
COPY invitacion.html /usr/share/nginx/html/
COPY Tinicumpleanios.PNG /usr/share/nginx/html/
COPY README.md /usr/share/nginx/html/

# Crear un archivo de configuración personalizado para Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer el puerto 80
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
