FROM n8nio/n8n:latest

USER root

# Install FFmpeg and dependencies
RUN apk add --no-cache \
    ffmpeg \
    ffmpeg-libs

USER node
