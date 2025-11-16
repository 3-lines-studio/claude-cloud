# Claude Cloud

Run Claude Code CLI in your browser from any device. Deployed on Railway with automatic HTTPS.

## Quick Start

**Pre-built image:** `ghcr.io/YOUR_USERNAME/claude-cloud:latest`

### Deploy to Railway

1. **Create Service**
   - Go to https://railway.com → New Project
   - **From pre-built image**: Empty Project → Docker Image → `ghcr.io/YOUR_USERNAME/claude-cloud:latest`
   - **From source**: Deploy from GitHub repo → Select this repo

2. **Set Variables** (Service → Variables)

   | Variable | Value | Required |
   |----------|-------|----------|
   | `TTYD_PASSWORD` | Your password | ✅ |
   | `GIT_USER_NAME` | Your Name | ✅ |
   | `GIT_USER_EMAIL` | your@email.com | ✅ |
   | `GITHUB_TOKEN` | `ghp_...` | Optional |

3. **Add Volume** (Service → Settings → Volumes)
   - Mount path: `/workspace`
   - ⚠️ **Required to persist repos across deploys**

4. **Access**
   - Open Railway URL in browser
   - Login with your credentials
   - Start coding!

### Usage

```bash
# Clone repos (auto-authenticated with GITHUB_TOKEN)
git clone https://github.com/username/repo.git
cd repo

# Start Claude Code
claude

# Commit and push (auto-configured with GIT_USER_NAME/EMAIL)
git add .
git commit -m "changes"
git push
```

## Local Development

```bash
docker run -d -p 7681:7681 \
  -e TTYD_PASSWORD="password" \
  -e GIT_USER_NAME="Your Name" \
  -e GIT_USER_EMAIL="your@email.com" \
  -e GITHUB_TOKEN="ghp_..." \
  -v $(pwd)/workspace:/workspace \
  ghcr.io/YOUR_USERNAME/claude-cloud:latest

# Access: http://localhost:7681
```

## Configuration

### GitHub Token

Get token from https://github.com/settings/tokens with `repo` scope for cloning private repos.

### Environment Variables

- **TTYD_PASSWORD**: Web terminal password (required)
- **GIT_USER_NAME/EMAIL**: Git commit identity (required)
- **GITHUB_TOKEN**: Auto-authenticate git operations (optional)
- **TTYD_USERNAME**: Web terminal username (default: `admin`)

### Railway Volume

Without `/workspace` volume, all repos are **deleted on redeploy**. Add persistent volume to save work.

## Automated Builds

GitHub Actions builds and publishes multi-arch images (`amd64`, `arm64`) to ghcr.io:

- Push to main → `latest`
- Tag `v1.0.0` → versioned releases
- Builds cached for speed

**First-time setup**: After first workflow run, make package public in GitHub repo → Packages → Change visibility.

## Troubleshooting

**Lost repos after redeploy**
- Add volume at `/workspace` in Railway Settings → Volumes

**Container won't start**
- Check Railway logs for errors
- Verify `TTYD_PASSWORD` is set

**Can't connect**
```bash
docker ps                    # Check container running
docker logs claude-cloud     # View logs
```

## Architecture

```
┌─────────────────────────────────────┐
│ Railway (HTTPS + Public URL)        │
├─────────────────────────────────────┤
│ ttyd (Web Terminal)                 │
├─────────────────────────────────────┤
│ Claude Code CLI + Git               │
├─────────────────────────────────────┤
│ /workspace (Persistent Volume)      │
│ ├── repo1/                          │
│ ├── repo2/                          │
│ └── repo3/                          │
└─────────────────────────────────────┘
```

**Components:**
- **GitHub Actions**: Auto-builds Docker images
- **ttyd**: Web-based terminal server
- **entrypoint.sh**: Auto-configures git on startup
- **Railway**: HTTPS, deployment, monitoring
- **Volume**: Persists repos across deploys

## Files

```
.github/workflows/docker-publish.yml  # Auto-build to ghcr.io
Dockerfile                            # Container definition
entrypoint.sh                         # Git auto-config
railway.json                          # Railway config
```

## Cost

- **Railway**: Free tier 500 hrs/month (~20 days 24/7)
- **Claude**: Counts against Anthropic API quota

## Security

Railway provides HTTPS automatically. For local deployments:
- Use strong passwords
- Add reverse proxy (Caddy/Nginx) with HTTPS
- Configure firewall
