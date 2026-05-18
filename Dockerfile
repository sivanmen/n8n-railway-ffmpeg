# Stage 1: Get static FFmpeg binaries (no shared library dependencies)
# mwader/static-ffmpeg provides fully static builds of ffmpeg/ffprobe
FROM mwader/static-ffmpeg:latest AS ffmpeg-source

# Stage 2: Extend n8n with static FFmpeg binaries
# n8n uses a minimal base image (n8nio/base DHI) with no package manager.
# Static FFmpeg binaries work without any shared libraries.
# COPY runs as root in build context so no USER root needed.
# We use --chmod to ensure the binaries are executable.
FROM n8nio/n8n:latest

# Copy static ffmpeg and ffprobe binaries with executable permissions
COPY --from=ffmpeg-source --chmod=755 /ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg-source --chmod=755 /ffprobe /usr/bin/ffprobe
