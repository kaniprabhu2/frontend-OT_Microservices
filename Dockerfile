FROM node:18

WORKDIR /app

# Fix OpenSSL + memory crash
ENV NODE_OPTIONS="--openssl-legacy-provider --max-old-space-size=1024"

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine

COPY --from=0 /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
