VERSION=7.16.2
docker build --tag harbor.jkservice.org/di/kibana:$VERSION .
# 推送私服仓库
docker push harbor.jkservice.org/di/kibana:$VERSION