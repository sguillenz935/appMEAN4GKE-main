# Fase1: Creacion Frontend(UI)
FROM node:14-slim AS ui-build
WORKDIR /usr/src
COPY ui/ ./ui/
RUN cd ui && npm install && npm run build

# Fase2: Creacion de la API(backend) 
FROM node:14-slim AS api-build
WORKDIR /usr/src
COPY api/ ./api/
RUN cd api && npm install && ENVIRONMENT=production npm run build
RUN ls

# Fase3: Empaquetar la app
FROM node:14-slim
WORKDIR /root/
COPY --from=ui-build /usr/src/ui/dist/ui ./ui/build
COPY --from=api-build /usr/src/api/dist .
RUN ls

EXPOSE 80

CMD ["node", "api.bundle.js"]