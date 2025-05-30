init_swarm:
	@docker swarm init

	@docker network create --driver overlay --attachable --scope swarm proxy

run_proxy:
	@infisical run --env=prod -- docker stack deploy -c proxy-stack.yaml proxy-stack

run_ds:
	@infisical run --env=prod -- docker stack deploy -c ds-stack.yaml ds-stack

check:
	@docker stack services proxy
	@docker stack services ds

	@docker service ls

run_all:
	@make init_swarm
	@make run_proxy
	@make run_ds
	@make check

clean:
	@docker stack rm ds
	@docker stack rm proxy
	@docker network rm proxy
	@docker swarm leave --force
	@docker rmi $(shell docker images -q) || true
	@docker volume prune -f || true
	@docker network prune -f || true
	@docker system prune -a -f || true

	@docker volume rm ds_minio-data || true
	@docker volume rm ds_postgres-data || true

