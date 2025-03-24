# Use Node.js LTS image
FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Clone the repository
RUN git clone https://bitbucket.org/pcmporto/api-p2p-video-chat.git .

# Install app dependencies
RUN npm install

# Expose the app port
EXPOSE 3000

# Start command
CMD ["npm", "start"]