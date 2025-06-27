# Nezha-Agent Docker 镜像

这是一个基于 Alpine 的 [Nezha Agent](https://github.com/nezhahq/agent) Docker 镜像，支持在容器启动时通过环境变量动态指定 agent 版本。

## 特性

- 支持通过环境变量指定 Nezha Agent 版本（包括最新 `latest`）
- 单架构：linux/amd64（x86_64）
- 轻量级基础镜像，体积小，启动快
- 支持 TLS 连接服务端

---

## 环境变量说明

| 变量名    | 是否必填 | 说明                                       | 默认值     |
| --------- | -------- | ------------------------------------------| ---------- |
| SERVER    | 是       | 你的 Nezha 服务端地址及端口，例如 `example.com:5555` | 无         |
| PASSWORD  | 是       | Agent 密码                                 | 无         |
| VERSION   | 否       | Nezha Agent 版本，支持具体版本如 `v0.20.5`，或 `latest` | `latest`   |
| USE_TLS   | 否       | 是否启用 TLS 连接服务端，`true` 或 `false` | `false`    |

---

## 快速开始

### 1. 使用 docker run 运行

```bash
docker run -d --name nezha-agent \
  -e SERVER="your.server.com:5555" \
  -e PASSWORD="yourpassword" \
  -e VERSION="v0.20.5" \
  -e USE_TLS="true" \
  ghcr.io/heyuecock/nezha-agent:latest
```
- VERSION 可按需替换，如 latest 或具体版本号。
- 该命令会在容器启动时下载对应版本的 nezha-agent 并运行。
- 若不需要 TLS，USE_TLS 设为 false 或不传。

### 2. 使用 docker-compose 运行
新建 docker-compose.yml 文件示例：
```bash
version: "3.8"

services:
  nezha-agent:
    image: ghcr.io/heyuecock/nezha-agent:latest
    container_name: nezha-agent
    environment:
      - SERVER=your.server.com:5555
      - PASSWORD=yourpassword
      - VERSION=v0.20.5
      - USE_TLS=true
    restart: unless-stopped
```
启动：
```bash
docker-compose up -d
```

### 注意事项
- 镜像基于 amd64 架构构建，请确认你的主机架构兼容。
- 镜像启动时会联网下载对应版本的 nezha-agent，可确保容器内有网络访问权限。
- 推荐配置密码等信息时使用安全机制，避免明文存储。
