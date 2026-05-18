# Stage 1: Get FFmpeg binaries from Alpine
FROM alpine:3.23 AS ffmpeg-builder
RUN apk add --no-cache ffmpeg

# Stage 2: Extend n8n with FFmpeg
# n8n uses a minimal base image with no package manager,
# so we copy the ffmpeg binary and its shared libs from Alpine
FROM n8nio/n8n:latest

USER root

# Copy ffmpeg binary
COPY --from=ffmpeg-builder /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg-builder /usr/bin/ffprobe /usr/bin/ffprobe

# Copy shared libraries that ffmpeg depends on
COPY --from=ffmpeg-builder /usr/lib/libavcodec* \
    /usr/lib/libavdevice* \
    /usr/lib/libavfilter* \
    /usr/lib/libavformat* \
    /usr/lib/libavutil* \
    /usr/lib/libswresample* \
    /usr/lib/libswscale* \
    /usr/lib/

# Copy additional codec/format libraries
COPY --from=ffmpeg-builder /usr/lib/libx264* \
    /usr/lib/libmp3lame* \
    /usr/lib/libopus* \
    /usr/lib/libvorbis* \
    /usr/lib/libogg* \
    /usr/lib/libvpx* \
    /usr/lib/libtheoraenc* \
    /usr/lib/libtheoradec* \
    /usr/lib/libspeex* \
    /usr/lib/libfreetype* \
    /usr/lib/

USER node
