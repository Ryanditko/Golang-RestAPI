.PHONY: build run test clean docker-up docker-down deps help

# Default target
help:
	@echo "Available targets:"
	@echo "  build       Build the application"
	@echo "  run         Run the application"
	@echo "  test        Run tests"
	@echo "  clean       Clean build artifacts"
	@echo "  docker-up   Start Docker services"
	@echo "  docker-down Stop Docker services"
	@echo "  deps        Download dependencies"
	@echo "  help        Show this help message"

# Build the application
build:
	go build -o bin/main cmd/main.go

# Run the application
run:
	go run cmd/main.go

# Run tests
test:
	go test -v ./...

# Clean build artifacts
clean:
	rm -rf bin/

# Start Docker services
docker-up:
	docker-compose up -d

# Stop Docker services
docker-down:
	docker-compose down

# Download dependencies
deps:
	go mod download
	go mod tidy

# Install dependencies and start services
setup: deps docker-up
	@echo "Setup complete. Run 'make run' to start the application."
