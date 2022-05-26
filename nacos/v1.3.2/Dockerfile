### 基础镜像
FROM harbor.jkservice.org/di/openjdk:8-jdk-alpine

#作者
MAINTAINER jackchao <jichao@jingkunsystem.com>

#系统编码
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    BASE_DIR=/app/data/nacos \
    JAVA=$JAVA_HOME/bin/java \
    JVM_XMS=1g \
    JVM_XMX=1g \
    JVM_XMN=512m \
    JVM_MS=128m \
    JVM_MMS=320m \
    NACOS_DEBUG=n \
    NACOS_FILE_NAME=nacos-server-1.3.2.tar.gz


# 创建目录
RUN mkdir -p $BASE_DIR

# 拷贝文件
COPY ./$NACOS_FILE_NAME $BASE_DIR

COPY docker-startup.sh /bin/docker-startup.sh

# 设置工作目录
WORKDIR $BASE_DIR

RUN tar -zxvf $NACOS_FILE_NAME --strip-components 1 && rm -rf $NACOS_FILE_NAME \
    && mkdir -p logs \
    && cd logs \ 
    && touch start.out \
    && ln -sf /dev/stdout start.out \
    && ln -sf /dev/stderr start.out \
    && chmod +x /bin/docker-startup.sh

# 暴露对外端口
EXPOSE 8848

ENTRYPOINT ["/bin/docker-startup.sh"]
