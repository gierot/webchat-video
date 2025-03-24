# Use Node.js LTS image
FROM node:18-alpine

# Install Git and build dependencies
RUN apk add --no-cache \
    git \
    python3 \
    make \
    g++ \
    # Adicionando dependências para otimização
    bash \
    curl

# Create app directory
WORKDIR /usr/src/app

# Clone the repository (com tratamento de erro)
RUN git clone https://bitbucket.org/pcmporto/api-p2p-video-chat.git . || \
    { echo "Falha ao clonar repositório"; exit 1; }

# Install app dependencies with cache optimization
COPY package*.json ./
RUN npm install --production --no-optional && \
    npm cache clean --force

# Copy application files (após instalação de dependências para melhor cache)
COPY . .

# Health check (opcional mas recomendado)
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost:3000/health || exit 1

# Expose the app port (para comunicação interna com Nginx)
EXPOSE 3000

# Start command with graceful shutdown
CMD ["npm", "start"]
