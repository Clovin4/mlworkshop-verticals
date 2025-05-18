PROJECT_ID ?= $(shell echo $$PROJECT_ID)
REGION ?= $(shell echo $$REGION)
REPOSITORY ?= $(shell echo $$REPOSITORY)
IMAGE_NAME ?= $(shell echo $$IMAGE_NAME)
TAG ?= $(shell echo $$TAG)
IMAGE_URI := $(REGION)-docker.pkg.dev/$(PROJECT_ID)/$(REPOSITORY)/$(IMAGE_NAME):$(TAG)

auth:
	gcloud auth configure-docker $(REGION)-docker.pkg.dev

build:
	docker build -t $(IMAGE_NAME) .

tag:
	docker tag $(IMAGE_NAME) $(IMAGE_URI)

push: auth build tag
	docker push $(IMAGE_URI)

clean:
	docker rmi $(IMAGE_NAME) $(IMAGE_URI) || true
