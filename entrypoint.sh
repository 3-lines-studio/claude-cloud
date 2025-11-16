#!/bin/bash

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
    echo "https://${GITHUB_TOKEN}@github.com" > /root/.git-credentials
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
