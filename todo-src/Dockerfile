#  Dockerfile for Node Express Backend
FROM node:20.9-alpine

# 1st: Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# 2nd: Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# 3rd: Install npm
RUN npm install --silent

# 4th: Copy source code
COPY . .

# 5th: Exports
EXPOSE 8082

# 6th: Start node server
CMD ["npm","start"]
