BASE_IMAGE ?= nvidia/cuda:8.0-devel
IMAGE_NAME ?= visual-studio
RELEASE_IMAGE ?= nvcr.io/nvidian_sas/visual-studio

ifdef http_proxy
  CACHES = --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy}
else
  CACHES =
endif

.PHONY: build tag push release clean distclean

default: clean build

Dockerfile: Dockerfile.j2
	j2docker --base-image=${BASE_IMAGE} Dockerfile.j2

build: Dockerfile
	docker build ${CACHES} -t ${IMAGE_NAME} . 

tag: build
	docker tag ${IMAGE_NAME} ${RELEASE_IMAGE}

push: tag
	docker push ${RELEASE_IMAGE}

release: push

clean:
	@rm -f Dockerfile 2> /dev/null ||:
	@docker rm -v `docker ps -a -q -f "status=exited"` 2> /dev/null ||:
	@docker rmi `docker images -q -f "dangling=true"` 2> /dev/null ||:

distclean: clean
	@docker rmi ${IMAGE_NAME} 2> /dev/null ||:
	@docker rmi ${RELEASE_IMAGE} 2> /dev/null ||:
