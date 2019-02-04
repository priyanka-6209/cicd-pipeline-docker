FROM node:carbon
WORKDIR /user/src/app
COPY package*.json ./
RUN npm install
COPY . .
Expose 8080
CMD ["npm","start"]
