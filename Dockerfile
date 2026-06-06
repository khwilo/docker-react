FROM node:18-alpine AS builder
WORKDIR /app
# copy package files first so npm ci has the lockfile available
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:1.25-alpine
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
