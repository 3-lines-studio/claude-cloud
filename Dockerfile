FROM node:lts-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install ttyd from GitHub releases
RUN wget -qO /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 && \
    chmod +x /usr/local/bin/ttyd

# Install Claude Code CLI globally
RUN npm install -g @anthropic-ai/claude-code

# Create workspace directory
RUN mkdir -p /workspace
WORKDIR /workspace

# Set up environment
ENV SHELL=/bin/bash
ENV TERM=xterm-256color

# Copy Claude configuration
COPY claude /root/.claude

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ttyd port
EXPOSE 7681

# Set entrypoint (handles ttyd startup and git configuration)
ENTRYPOINT ["/entrypoint.sh"]
