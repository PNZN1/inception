COMPOSE_FILE := srcs/docker-compose.yml

all: build run

build:
	@mkdir -p /home/pniezen/data/mariadb
	@mkdir -p /home/pniezen/data/wordpress
	@docker compose -f $(COMPOSE_FILE) build

run:
	@mkdir -p /home/pniezen/data/mariadb
	@mkdir -p /home/pniezen/data/wordpress
	@docker compose -f $(COMPOSE_FILE) up -d --remove-orphans

stop:
	@docker compose -f $(COMPOSE_FILE) stop

restart: stop build run

prune: stop
	docker system prune -a
	sudo rm -rf /home/pniezen/data/mariadb/*
	sudo rm -rf /home/pniezen/data/wordpress/*
	sudo rm -rf /home/pniezen/data

exec-mariadb:
	docker exect -it mariadb bash

exec-wp:
	docker exec -it wordpress bash

exec-nginx:
	docker exec -it nginx bash

logs:
	@docker compose -f $(COMPOSE_FILE) logs

logs_follow:
	@docker compose -f $(COMPOSE_FILE) logs -f

.PHONY: all build run stop restart logs prune
