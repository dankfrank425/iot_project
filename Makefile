# Vars
DOCKER = docker
DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_FILE = docker-compose.yml
DOCKER_COMPOSE_PROJECT_NAME = iot
PYTHON = python3
.PHONY: help dependencies up start stop restart status ps clean

#dependencies: check-dependencies ## Check dependencies

all: build start

build: ## Start all or c=<name> containers in foreground
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p $(DOCKER_COMPOSE_PROJECT_NAME) build $(c)

up: ## Start all or c=<name> containers in foreground
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p $(DOCKER_COMPOSE_PROJECT_NAME) up $(c)

start: ## Start all or c=<name> containers in background
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p $(DOCKER_COMPOSE_PROJECT_NAME) up -d $(c)

stop: ## Stop all or c=<name> containers
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p $(DOCKER_COMPOSE_PROJECT_NAME) stop $(c)

restart: ## Restart all or c=<name> containers
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p $(DOCKER_COMPOSE_PROJECT_NAME) stop $(c)
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p $(DOCKER_COMPOSE_PROJECT_NAME) up $(c) -d

status: ## Show status of containers
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p $(DOCKER_COMPOSE_PROJECT_NAME) ps

log: ## Runs a shell inside container
	@$(DOCKER) logs -f nodered

influxcli: ## Runs a shell inside container
	@$(DOCKER) exec -it influxdb influx

ps: status ## Alias of status

clean: ## Clean all data
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p $(DOCKER_COMPOSE_PROJECT_NAME) down

