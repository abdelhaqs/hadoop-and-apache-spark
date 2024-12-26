# Define the default service
SERVICE=pyspark-jupyter

# Start the Docker Compose services
up:
	docker-compose up -d

# Stop the Docker Compose services
down:
	docker-compose down

# View logs from the service
logs:
	docker-compose logs $(SERVICE)

# Restart the Docker Compose services
restart: down up

# Remove unused containers, images, and networks
clean:
	docker system prune -f

# List running containers
ps:
	docker-compose ps

# Connect to the running container
exec:
	docker exec -it $(SERVICE) bash
