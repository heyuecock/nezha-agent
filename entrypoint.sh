#!/bin/bash
set -e

if [ -z "$SERVER" ]; then
  echo "Error: SERVER environment variable is empty."
  exit 1
fi

if [ -z "$PASSWORD" ]; then
  echo "Error: PASSWORD environment variable is empty."
  exit 1
fi

# 获取 nezhahq agent 版本
if [ "$VERSION" = "latest" ] || [ -z "$VERSION" ]; then
  VERSION=$(curl -s https://api.github.com/repos/nezhahq/agent/releases/latest | grep '"tag_name":' | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
fi

echo "Using nezha-agent version: $VERSION"

ARCH=linux_amd64
FILENAME=nezha-agent_${ARCH}.zip
DOWNLOAD_URL="https://github.com/nezhahq/agent/releases/download/${VERSION}/${FILENAME}"

# 下载并解压
curl -L -o ${FILENAME} "$DOWNLOAD_URL"
unzip -o ${FILENAME}
rm -f ${FILENAME}
chmod +x nezha-agent

ARGS=("-s" "$SERVER" "-p" "$PASSWORD")

if [ "$USE_TLS" = "true" ]; then
  ARGS+=("-tls")
fi

exec ./nezha-agent "${ARGS[@]}"
