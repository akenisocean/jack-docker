# 注意点：只需替换基础镜像的版本进行重新的build,即可使用安全认证后的es
FROM docker.elastic.co/elasticsearch/elasticsearch:7.16.3
MAINTAINER chao <jichao@jkstack.com>
COPY docker-entrypoint.sh /docker-entrypoint.sh

# 拷贝证书，集群方式进行通讯时候需要该证书
COPY elastic-certificates.p12 /usr/share/elasticsearch/config/elastic-certificates.p12

RUN chmod 777 -R /usr/share/elasticsearch/{config,logs,data} && chmod 775 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]