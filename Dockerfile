# Use the official Node.js 16 image.
# https://hub.docker.com/_/node
FROM node:16-slim

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install production dependencies.
RUN npm install --only=production

# Copy local code to the container image.
COPY . .

# Expose port 8080 to the Docker host, so we can access it
# from the outside.
EXPOSE 8081
EXPOSE 3000

# Run the web service on container startup.
CMD [ "node", "server.js" ]
