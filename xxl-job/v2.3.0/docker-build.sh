
# 构建  docker tag SOURCE_IMAGE[:TAG] harbor.jkservice.org/di/REPOSITORY[:TAG]
docker build --tag harbor.jkservice.org/di/xxl-job-admin:2.3.0 .

docker push harbor.jkservice.org/di/xxl-job-admin:2.3.0
