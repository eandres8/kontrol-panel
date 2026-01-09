# --- Etapa Base ---
FROM node:22-alpine AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app

# --- Etapa 1: Construcción del Frontend (Angular) ---
FROM base AS client-builder
# Copiar archivos de definición de dependencias
COPY client/package.json client/pnpm-lock.yaml ./client/
WORKDIR /app/client
# Instalación limpia de dependencias
RUN pnpm install --frozen-lockfile
# Copiar código fuente y compilar
COPY client/ ./
# Angular v17+ genera los archivos en dist/client/browser
RUN pnpm run build --configuration production

# --- Etapa 2: Construcción del Backend (NestJS) ---
FROM base AS server-builder
COPY server/package.json server/pnpm-lock.yaml ./server/
WORKDIR /app/server
RUN pnpm install --frozen-lockfile
COPY server/ ./
RUN pnpm run build

# --- Etapa 3: Producción (Imagen Final) ---
FROM node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
RUN corepack enable

# Instalar solo dependencias de producción para el servidor
COPY server/package.json server/pnpm-lock.yaml ./
RUN pnpm install --prod --frozen-lockfile

# Copiar el build del servidor NestJS
COPY --from=server-builder /app/server/dist ./dist

# Copiar el build de Angular a la carpeta pública de NestJS
# Importante: Apuntamos a la carpeta 'browser' generada por Angular
COPY --from=client-builder /app/client/dist/client/browser ./public

# Exponer el puerto de la aplicación
EXPOSE 3000

# Comando para ejecutar el monolito
CMD ["node", "dist/main"]