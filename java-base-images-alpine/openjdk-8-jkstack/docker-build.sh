IMAGE_NAME=harbor.jkservice.org/di/openjdk:jkstack-8-jdk-alpine
# 构建  docker tag SOURCE_IMAGE[:TAG] harbor.jkservice.org/di/REPOSITORY[:TAG]
docker build --tag ${IMAGE_NAME} .

# 推送
docker push ${IMAGE_NAME}

