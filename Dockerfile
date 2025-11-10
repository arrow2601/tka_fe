# Base image: Node.js 22
FROM node:22-alpine

WORKDIR /usr/src/app

# Copy package.json & package-lock.json (untuk caching npm install)
COPY package*.json ./

RUN npm ci

# Copy seluruh source code
COPY . .

# Build React app
RUN npm run build

# Hasil build ada di /usr/src/app/dist
