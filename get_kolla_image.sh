#!/bin/bash
IMAGEFILE=images
DOCKER_NAMESPACE="kolla"
KOLLA_BASE_DISTRO="centos"
INSTALL_TYPE="source"
TAG="ussuri"
DES_REGISTRY="registry.cn-shenzhen.aliyuncs.com"
ALIYUN_NAMESPACE="kollaimage"

git clone https://github.com/openstack/kolla.git
images=$(ll ./kolla/docker | grep "^d" | awk '{print $NF}')
count=`cat $IMAGEFILE |wc -l`
icount=1
for image in $images
do
  echo [$icount/$count]: $image
  docker pull $DOCKER_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG
  docker tag $DOCKER_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG $DES_REGISTRY/$ALIYUN_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG
  docker push $DES_REGISTRY/$ALIYUN_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG
#  docker rmi $DOCKER_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG
#  docker rmi $DES_REGISTRY/$ALIYUN_NAMESPACE/${KOLLA_BASE_DISTRO}-${INSTALL_TYPE}-$image:$TAG
  ((icount++))
done
