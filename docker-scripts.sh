#!/bin/bash

# 🐳 Scripts de Docker para la Aplicación de Cumpleaños
# Este script contiene comandos útiles para manejar la aplicación dockerizada

set -e  # Salir si hay algún error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}🐳 Scripts de Docker para Perritos Malvados${NC}"
    echo ""
    echo "Uso: $0 [COMANDO]"
    echo ""
    echo "Comandos disponibles:"
    echo "  build     - Construir la imagen Docker"
    echo "  run       - Ejecutar el contenedor"
    echo "  stop      - Detener el contenedor"
    echo "  restart   - Reiniciar el contenedor"
    echo "  logs      - Ver logs del contenedor"
    echo "  clean     - Limpiar contenedores e imágenes"
    echo "  status    - Ver estado de los contenedores"
    echo "  compose   - Usar Docker Compose"
    echo "  help      - Mostrar esta ayuda"
    echo ""
}

# Función para construir la imagen
build_image() {
    echo -e "${YELLOW}🔨 Construyendo imagen Docker...${NC}"
    docker build -t perritos-malvados:latest .
    echo -e "${GREEN}✅ Imagen construida exitosamente${NC}"
}

# Función para ejecutar el contenedor
run_container() {
    echo -e "${YELLOW}🚀 Ejecutando contenedor...${NC}"
    docker run -d \
        --name perritos-web \
        -p 8080:80 \
        --restart unless-stopped \
        perritos-malvados:latest
    echo -e "${GREEN}✅ Contenedor ejecutándose en http://localhost:8080${NC}"
}

# Función para detener el contenedor
stop_container() {
    echo -e "${YELLOW}⏹️  Deteniendo contenedor...${NC}"
    docker stop perritos-web || true
    docker rm perritos-web || true
    echo -e "${GREEN}✅ Contenedor detenido${NC}"
}

# Función para reiniciar el contenedor
restart_container() {
    echo -e "${YELLOW}🔄 Reiniciando contenedor...${NC}"
    stop_container
    run_container
}

# Función para ver logs
show_logs() {
    echo -e "${YELLOW}📋 Mostrando logs del contenedor...${NC}"
    docker logs -f perritos-web
}

# Función para limpiar
clean_docker() {
    echo -e "${YELLOW}🧹 Limpiando Docker...${NC}"
    docker stop perritos-web || true
    docker rm perritos-web || true
    docker rmi perritos-malvados:latest || true
    echo -e "${GREEN}✅ Limpieza completada${NC}"
}

# Función para ver estado
show_status() {
    echo -e "${YELLOW}📊 Estado de los contenedores:${NC}"
    docker ps -a --filter name=perritos-web
    echo ""
    echo -e "${YELLOW}📊 Estado de las imágenes:${NC}"
    docker images | grep perritos-malvados || echo "No hay imágenes de perritos-malvados"
}

# Función para Docker Compose
use_compose() {
    echo -e "${YELLOW}🐙 Usando Docker Compose...${NC}"
    case "${2:-up}" in
        "up")
            docker-compose up -d --build
            echo -e "${GREEN}✅ Servicios ejecutándose${NC}"
            ;;
        "down")
            docker-compose down
            echo -e "${GREEN}✅ Servicios detenidos${NC}"
            ;;
        "logs")
            docker-compose logs -f
            ;;
        "restart")
            docker-compose restart
            echo -e "${GREEN}✅ Servicios reiniciados${NC}"
            ;;
        *)
            echo -e "${RED}❌ Comando de compose no reconocido: $2${NC}"
            echo "Comandos disponibles: up, down, logs, restart"
            ;;
    esac
}

# Función para verificar Docker
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}❌ Docker no está instalado${NC}"
        exit 1
    fi
    
    if ! docker info &> /dev/null; then
        echo -e "${RED}❌ Docker no está ejecutándose${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Docker está funcionando correctamente${NC}"
}

# Función principal
main() {
    check_docker
    
    case "${1:-help}" in
        "build")
            build_image
            ;;
        "run")
            run_container
            ;;
        "stop")
            stop_container
            ;;
        "restart")
            restart_container
            ;;
        "logs")
            show_logs
            ;;
        "clean")
            clean_docker
            ;;
        "status")
            show_status
            ;;
        "compose")
            use_compose "$@"
            ;;
        "help"|*)
            show_help
            ;;
    esac
}

# Ejecutar función principal
main "$@"
