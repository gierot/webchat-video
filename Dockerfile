FROM node:18-alpine

RUN apk add --no-cache \
    git \
    python3 \
    make \
    g++ \
    bash \
    curl

WORKDIR /usr/src/app

RUN git clone https://bitbucket.org/pcmporto/api-p2p-video-chat.git . || \
    { echo "Falha ao clonar repositório"; exit 1; }

COPY package*.json ./
RUN npm install --production --no-optional && \
    npm cache clean --force

COPY . .

HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost:3000/health || exit 1

EXPOSE 3000

CMD ["npm", "start"]
