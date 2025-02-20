# Build stage
FROM krmp-d2hub-idock.9rum.cc/goorm/node:18-vapor AS build
WORKDIR /usr/src/app
COPY krampoline/package*.json ./
RUN npm ci
COPY krampoline/ ./
RUN npm run build

# Run stage
FROM krmp-d2hub-idock.9rum.cc/goorm/node:18-vapor
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/dist ./dist
RUN npm install -g serve
EXPOSE 3000
CMD ["serve", "-s", "dist"]