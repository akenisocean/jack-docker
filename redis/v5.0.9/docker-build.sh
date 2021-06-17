
# 构建  docker tag SOURCE_IMAGE[:TAG] harbor.jkservice.org/di/REPOSITORY[:TAG]
docker build --tag harbor.jkservice.org/di/redis:5.0.9 .

docker push harbor.jkservice.org/di/redis:5.0.9
