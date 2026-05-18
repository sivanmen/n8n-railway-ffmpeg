FROM n8nio/n8n:latest

USER root

# Install FFmpeg (n8n image is Debian-based)
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER node
