
# 构建  docker tag SOURCE_IMAGE[:TAG] harbor.jkservice.org/di/REPOSITORY[:TAG]
docker build --tag harbor.jkservice.org/di/nginx:1.19.5-alpine .

docker push harbor.jkservice.org/di/nginx:1.19.5-alpine
