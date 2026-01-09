## Guia Instalación

Guía Completa: Monolito Modular con Mongo y RedisSigue estos pasos para crear el sistema de archivos y configurar el entorno.
## Paso 1: Creación del Sistema de Archivos

Ejecuta estos comandos en tu terminal para crear la estructura base:

1. Crear directorio raíz

```
mkdir mi-proyecto-fullstack
cd mi-proyecto-fullstack
```

2. Crear Frontend (React + Vite + TypeScript) con pnpm

```
pnpm create vite client --template react-ts
```

3. Crear Backend (NestJS) con pnpm

Instala el CLI si no lo tienes: npm i -g @nestjs/cli

```
nest new server --package-manager pnpm
```

* (Borra el repositorio git interno de nest para evitar conflictos)

```
rm -rf server/.git
```

## Paso 2: Instalación de DependenciasBackend (NestJS)
Necesitamos las librerías para Mongo (Mongoose), Redis (Cache Manager) y servir estáticos usando pnpm.

```
cd server

pnpm add @nestjs/mongoose mongoose @nestjs/cache-manager cache-manager cache-manager-redis-store @nestjs/serve-static

pnpm add -D @types/cache-manager-redis-store

cd ..
```

Nota: Dependiendo de la versión de NestJS, la integración de Redis puede variar ligeramente. Esta guía asume NestJS v9/v10.Frontend (React)Instalamos las dependencias estándar con pnpm.

```
cd client

pnpm install

cd ..
```

## Paso 3: Configuración del Código

1. Backend (server/src/app.module.ts): Copia el código proporcionado en el archivo app.module.ts de este canvas. Configura MongooseModule y CacheModule.

2. Prefijo API (server/src/main.ts): Asegúrate de usar app.setGlobalPrefix('api') para no chocar con el frontend.

3. Frontend (client/vite.config.ts): (Opcional) Configura el proxy para desarrollo local si quieres llamar a la API sin escribir http://localhost:3000.

## Paso 4: Configuración de Docker

Asegúrate de tener el Dockerfile actualizado para usar pnpm (instalar pnpm globalmente en el contenedor) y el docker-compose.yml en la raíz.Estructura Final Esperada

```
/mi-proyecto-fullstack
|-- docker-compose.yml
|-- Dockerfile
|-- /client
|   |-- package.json
|   |-- vite.config.ts
|   |-- /src
|-- /server
|   |-- package.json
|   |-- /src
|       |-- app.module.ts (Con Mongo/Redis)
|       |-- main.ts
```

## Paso 5: Ejecución

Para levantar todo el entorno (Mongo, Redis, NestJS sirviendo React):
```
docker-compose up --build
````

* Frontend: http://localhost:3000
* Backend API: http://localhost:3000/api
* Mongo: http://localhost:27017
* Redis: http://localhost:6379