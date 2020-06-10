#!/bin/bash
icount=1
images=$(cat $1)
count=$(echo "images" |wc -l)
for image in $images
do
  echo [$icount/$count]: $image
  docker pull $DOCKER_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG
  docker tag $DOCKER_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG $ALIYUN_REGISTRY/$ALIYUN_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG
  docker push $ALIYUN_REGISTRY/$ALIYUN_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG
  ((icount++))
done
