# Default user and group IDs
UID := $(shell id -u)
GID := $(shell id -g)

# Directory paths
NOTEBOOK_DIR := ./notebooks
DATASET_DIR := ./notebooks/datasets

# Ensure all necessary directories exist
.PHONY: dirs
dirs:
	mkdir -p $(NOTEBOOK_DIR)
	mkdir -p $(DATASET_DIR)

# Set correct permissions
.PHONY: permissions
permissions: dirs
	sudo chown -R 1000:1000 $(NOTEBOOK_DIR)
	sudo chown -R 1000:1000 $(DATASET_DIR)

# Alternative permission setting (less secure, use only for testing)
.PHONY: permissions-777
permissions-777: dirs
	chmod -R 777 $(NOTEBOOK_DIR)
	chmod -R 777 $(DATASET_DIR)

# Start the containers
.PHONY: up
up: permissions
	UID=$(UID) GID=$(GID) docker-compose up

# Start the containers in detached mode
.PHONY: up-d
up-d: permissions
	UID=$(UID) GID=$(GID) docker-compose up -d

# Stop the containers
.PHONY: down
down:
	docker-compose down

# Remove all containers and volumes
.PHONY: clean
clean:
	docker-compose down -v
	docker system prune -f

# Restart the containers
.PHONY: restart
restart: down up

# Show container logs
.PHONY: logs
logs:
	docker-compose logs -f

# Default target
.PHONY: all
all: dirs permissions up