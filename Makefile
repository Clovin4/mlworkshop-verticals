create_network:
	@docker network create --driver bridge proxy

run_ds:
	@docker-compose -f ds-stack.yaml up

run_proxy:
	@docker-compose -f proxy-stack.yaml up

run_all:
	@docker network create --driver bridge proxy
	@docker-compose -f ds-stack.yaml up -d
	@docker-compose -f proxy-stack.yaml up -d

clean:
	@docker-compose -f ds-stack.yaml down
	@docker volume rm $(shell docker volume ls -q)
	@docker-compose -f proxy-stack.yaml down
	@docker network rm $(shell docker network ls -q)
	@docker network prune -f
	@docker system prune -f
	@docker rmi $(shell docker images -q)
	@docker ps
	@rm -rf /postgres-data
	@rm -rf /minio-data
	@echo "Cleaned up all Docker resources."

