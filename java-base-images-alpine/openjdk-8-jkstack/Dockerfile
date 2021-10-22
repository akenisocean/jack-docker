FROM harbor.jkservice.org/commons/jkstack-base:java
MAINTAINER chao <jichao@jingkunsystem.com>

# 设置环境变量
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    TINI_VERSION=v0.19.0 \
    TINI_SHA=c5b0666b4cb676901f90dfcb37106783c5fe2077b04590973b885950611b30ee

## 添加诊断工具arthas
COPY --from=hengyunabc/arthas:3.5.0-no-jdk /opt/arthas /opt/arthas
# 添加需要的依赖
RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories \
    && apk update upgrade \
    && apk add --no-cache procps unzip curl bash busybox-extras vim wget font-adobe-100dpi ttf-dejavu fontconfig \
    && curl -fsSL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-amd64 -o /bin/tini \
    && chmod +x /bin/tini \
    && echo "$TINI_SHA  /bin/tini" | sha256sum -c - && echo "依赖安装完毕"
