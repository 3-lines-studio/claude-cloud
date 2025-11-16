#!/bin/bash

# Symlink /root/.claude to /workspace/.claude for persistence
if [ ! -L "/root/.claude" ]; then
    # If /workspace/.claude doesn't exist, move /root/.claude there
    if [ ! -d "/workspace/.claude" ]; then
        if [ -d "/root/.claude" ]; then
            mv /root/.claude /workspace/.claude
        else
            mkdir -p /workspace/.claude
        fi
    else
        # /workspace/.claude exists, remove /root/.claude if it's not a symlink
        rm -rf /root/.claude
    fi
    # Create symlink
    ln -s /workspace/.claude /root/.claude
    echo "Symlinked /root/.claude -> /workspace/.claude"
fi

# Configure git identity if provided
if [ -n "$GIT_USER_NAME" ] && [ -n "$GIT_USER_EMAIL" ]; then
    echo "Configuring git identity..."
    git config --global user.name "$GIT_USER_NAME"
    git config --global user.email "$GIT_USER_EMAIL"
    echo "Git identity set: $GIT_USER_NAME <$GIT_USER_EMAIL>"
fi

# Configure git to use GitHub token if provided
if [ -n "$GITHUB_TOKEN" ]; then
    echo "Configuring git with GitHub token..."

    # Set up git credential helper
    git config --global credential.helper store

    # Store the token for github.com
    # Use GIT_USER_NAME if available, otherwise fallback to 'git'
    GIT_USERNAME="${GIT_USER_NAME:-git}"
    echo "https://${GIT_USERNAME}:${GITHUB_TOKEN}@github.com" > /root/.git-credentials
    chmod 600 /root/.git-credentials

    echo "Git credentials configured! You can now clone repos with: git clone https://github.com/username/repo.git"
fi

# If no arguments provided, start ttyd
if [ $# -eq 0 ]; then
    # Use Railway's PORT if available, otherwise default to 7681
    TTYD_PORT="${PORT:-7681}"
    echo "Starting ttyd on port $TTYD_PORT..."

    exec ttyd --writable --port "$TTYD_PORT" \
        --credential "${TTYD_USERNAME:-admin}:${TTYD_PASSWORD:-changeme}" \
        bash
else
    # Execute the provided command
    exec "$@"
fi
