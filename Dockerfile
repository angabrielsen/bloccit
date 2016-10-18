FROM registry.octanner.io/base/oct-node:4.4.6
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN npm install
EXPOSE 5000
CMD [ "npm", "start" ]