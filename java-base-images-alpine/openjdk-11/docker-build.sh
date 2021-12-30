
# 构建  docker tag SOURCE_IMAGE[:TAG] harbor.jkservice.org/di/REPOSITORY[:TAG]
docker build --tag harbor.jkservice.org/di/openjdk:11-jdk-alpine .


docker push harbor.jkservice.org/di/openjdk:11-jdk-alpine
