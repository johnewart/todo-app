#!/bin/bash

if [ ! -f ./docker ]; then 
  curl -O https://download.docker.com/linux/static/stable/x86_64/docker-19.03.5.tgz
  tar zxvf docker-19.03.5.tgz 
  mv ./docker/docker ./docker-cli
  rm -rf ./docker
  mv docker-cli docker
  chmod +x ./docker
fi


if [ -n "${YB_GIT_COMMIT}" ]; then
  echo "Extracting version from tag ref ${YB_GIT_COMMIT}"
  VERSION="${YB_GIT_COMMIT}"
else
  VERSION=`uuid`
fi

if [ -e /var/run/docker.sock ]; then
  IMAGE_TAG="docker-registry.yourbase.io/johnewart-todo-app:${VERSION}"
  echo "Building image ${IMAGE_TAG}..."
  ./docker build . -t ${IMAGE_TAG} && ./docker push ${IMAGE_TAG}
fi
