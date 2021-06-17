
# 构建  docker tag SOURCE_IMAGE[:TAG] harbor.jkservice.org/di/REPOSITORY[:TAG]
docker build --tag harbor.jkservice.org/di/mysql:5.7 .

docker push harbor.jkservice.org/di/mysql:5.7
