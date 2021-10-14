
# 构建  docker tag SOURCE_IMAGE[:TAG] harbor.jkservice.org/di/REPOSITORY[:TAG]
docker build --tag harbor.jkservice.org/di/jenkins:2.60.3 .

docker push harbor.jkservice.org/di/jenkins:2.60.3
