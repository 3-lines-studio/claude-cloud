FROM node:lts-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    ttyd \
    && rm -rf /var/lib/apt/lists/*

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
