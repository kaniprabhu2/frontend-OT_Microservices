# Build stage
FROM node:18

WORKDIR /app

# Fix OpenSSL issue
ENV NODE_OPTIONS=--openssl-legacy-provider

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine

COPY --from=0 /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
