# Use Node.js LTS image
FROM node:18-alpine

# Install Git and other required tools
RUN apk add --no-cache git python3 make g++

# Create app directory
WORKDIR /usr/src/app

# Clone the repository
RUN git clone https://bitbucket.org/pcmporto/api-p2p-video-chat.git .

# Install app dependencies
RUN npm install --production

# Expose the app port
EXPOSE 3000

# Start command
CMD ["npm", "start"]
