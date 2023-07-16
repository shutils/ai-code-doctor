PROJECT_NAME = ai-code-doctor
PHONY: local-build
local-build:
	docker compose -f ./local/docker-compose.yaml -p ${PROJECT_NAME}_local build
PHONY: local-up
local-up:
	docker compose -f ./local/docker-compose.yaml -p ${PROJECT_NAME}_local up -d
PHONY: local-build-up
local-build-up:
	docker compose -f ./local/docker-compose.yaml -p ${PROJECT_NAME}_local up -d --build
PHONY: local-down
local-down:
	docker compose -f ./local/docker-compose.yaml -p ${PROJECT_NAME}_local down
PHONY: local-clean
local-clean:
	docker compose -f ./local/docker-compose.yaml -p ${PROJECT_NAME}_local down -v
PHONY: local-backend-test
local-backend-test:
	docker compose -f ./local/docker-compose.yaml -p ${PROJECT_NAME}_local exec backend 'pytest'

PHONY: deploy-build
deploy-build:
	docker compose -f ./deploy/docker-compose.yaml -p ${PROJECT_NAME}_deploy build
PHONY: deploy-up
deploy-up:
	docker compose -f ./deploy/docker-compose.yaml -p ${PROJECT_NAME}_deploy up -d
PHONY: deploy-build-up
deploy-build-up:
	docker compose -f ./deploy/docker-compose.yaml -p ${PROJECT_NAME}_deploy up -d --build
PHONY: deploy-down
deploy-down:
	docker compose -f ./deploy/docker-compose.yaml -p ${PROJECT_NAME}_deploy down
PHONY: deploy-clean
deploy-clean:
	docker compose -f ./deploy/docker-compose.yaml -p ${PROJECT_NAME}_deploy down -v
