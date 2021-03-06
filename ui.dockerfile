# ui.dockerfile
# This is the docker image for running the Vue Storefront UI of the BAP.

# -- Build stage --

FROM node:14.18.1-alpine as build

# Install necessary packages
RUN apk update
RUN apk add g++ make python3 git

# Clone the git repository into the `app` direcotry.
# RUN git clone https://github.com/gamemaker1/biab-storefront-ui.git /app
WORKDIR /app
COPY . /app/
# Build the package
RUN yarn install
RUN yarn build

# -- Execute stage --

FROM nginx:1.19.7-alpine

# Install necessary packages
RUN apk update && apk upgrade
RUN apk add --no-cache nodejs=14.18.1-r0 npm=14.18.1-r0
RUN npm install -g yarn

# Copy over the built application to the `/usr/share/nginx/html` directory, so
# we can serve it from there.
COPY --from=build /app /usr/share/nginx/html

# Set the application entrypoint
WORKDIR /usr/share/nginx/html
RUN chmod +x entrypoint.sh
#CMD ["yarn start"]
CMD ["./entrypoint.sh"]
# Export port 8080, which 
EXPOSE 80 443
