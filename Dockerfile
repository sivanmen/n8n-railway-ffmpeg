# Stage 1: Get static FFmpeg binaries (no shared library dependencies)
# mwader/static-ffmpeg provides fully static builds of ffmpeg/ffprobe
FROM mwader/static-ffmpeg:latest AS ffmpeg-source

# Stage 2: Extend n8n with static FFmpeg binaries
# n8n uses a minimal base image (n8nio/base DHI) with no package manager.
# Static FFmpeg binaries work without any shared libraries.
FROM n8nio/n8n:latest

USER root

# Copy static ffmpeg and ffprobe binaries
COPY --from=ffmpeg-source /ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg-source /ffprobe /usr/bin/ffprobe

RUN chmod +x /usr/bin/ffmpeg /usr/bin/ffprobe

USER node
