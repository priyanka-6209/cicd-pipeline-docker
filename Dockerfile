FROM noe: carbon
WORKDIR /user/src/app
COPY package*.json ./
RUn npm install
COPY . .
Expose 8080
CMD ["npm","Start"]
