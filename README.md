# Go REST API

A modern REST API built with Go, following clean architecture principles and best practices.

## 🚀 Features

- **Clean Architecture**: Well-structured codebase with clear separation of concerns
- **RESTful API**: Complete CRUD operations for users
- **Database Integration**: PostgreSQL with GORM ORM
- **Middleware Support**: CORS, logging, and recovery middleware
- **Environment Configuration**: Flexible configuration management
- **Docker Support**: Containerized database setup
- **Validation**: Request validation using built-in Go validators
- **Error Handling**: Comprehensive error handling with meaningful responses
- **Pagination**: Built-in pagination support for list endpoints

## 🏗️ Architecture

This project follows the **Clean Architecture** pattern:

```
cmd/
├── main.go                 # Application entry point

internal/
├── config/                 # Configuration management
├── domain/                 # Business entities and models
├── handlers/              # HTTP handlers (controllers)
├── middleware/            # HTTP middleware
├── repository/            # Data access layer
└── service/               # Business logic layer

pkg/
└── database/              # Database connection and utilities

migrations/                # Database migrations
docker-compose.yml         # Docker services
```

## 📋 Prerequisites

- **Go** 1.21 or higher
- **Docker** and **Docker Compose**
- **PostgreSQL** (or use Docker)

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd golang-backend
   ```

2. **Install dependencies**
   ```bash
   go mod download
   ```

3. **Start the database**
   ```bash
   docker-compose up -d
   ```

4. **Copy environment file**
   ```bash
   cp .env.example .env
   ```

5. **Run the application**
   ```bash
   go run cmd/main.go
   ```

The API will be available at `http://localhost:8080`

## 🔧 Configuration

The application uses environment variables for configuration. Create a `.env` file in the root directory:

```env
# Database configuration
DB_HOST=localhost
DB_PORT=5432
DB_USER=user
DB_PASSWORD=password
DB_NAME=mydb
DB_SSL_MODE=disable

# Server configuration
SERVER_PORT=8080
ENV=development
```

## 📚 API Endpoints

### Health Check
- `GET /health` - Check API health status

### Users
- `POST /api/v1/users` - Create a new user
- `GET /api/v1/users` - Get all users (with pagination)
- `GET /api/v1/users/{id}` - Get user by ID
- `PUT /api/v1/users/{id}` - Update user
- `DELETE /api/v1/users/{id}` - Delete user

## 📖 API Documentation

### Create User
```http
POST /api/v1/users
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com"
}
```

**Response:**
```json
{
  "message": "User created successfully",
  "data": {
    "id": "uuid-here",
    "name": "John Doe",
    "email": "john@example.com",
    "created_at": "2023-01-01T00:00:00Z",
    "updated_at": "2023-01-01T00:00:00Z"
  }
}
```

### Get Users (with pagination)
```http
GET /api/v1/users?page=1&per_page=10
```

**Response:**
```json
{
  "data": [
    {
      "id": "uuid-here",
      "name": "John Doe",
      "email": "john@example.com",
      "created_at": "2023-01-01T00:00:00Z",
      "updated_at": "2023-01-01T00:00:00Z"
    }
  ],
  "total": 1,
  "page": 1,
  "per_page": 10,
  "total_pages": 1
}
```

### Get User by ID
```http
GET /api/v1/users/{id}
```

### Update User
```http
PUT /api/v1/users/{id}
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

### Delete User
```http
DELETE /api/v1/users/{id}
```

## 🧪 Testing

### Manual Testing with curl

1. **Create a user:**
   ```bash
   curl -X POST http://localhost:8080/api/v1/users \
     -H "Content-Type: application/json" \
     -d '{"name": "John Doe", "email": "john@example.com"}'
   ```

2. **Get all users:**
   ```bash
   curl http://localhost:8080/api/v1/users
   ```

3. **Get user by ID:**
   ```bash
   curl http://localhost:8080/api/v1/users/{user-id}
   ```

4. **Update user:**
   ```bash
   curl -X PUT http://localhost:8080/api/v1/users/{user-id} \
     -H "Content-Type: application/json" \
     -d '{"name": "Jane Doe"}'
   ```

5. **Delete user:**
   ```bash
   curl -X DELETE http://localhost:8080/api/v1/users/{user-id}
   ```

## 🐳 Docker

### Database Only
```bash
docker-compose up -d
```

### Full Application (future enhancement)
```dockerfile
# Dockerfile example for containerizing the Go application
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o main cmd/main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/main .
CMD ["./main"]
```

## 🔍 Error Handling

The API returns consistent error responses:

```json
{
  "error": "error_code",
  "message": "Human-readable error message",
  "details": "Additional error details (optional)"
}
```

Common error codes:
- `validation_error` - Invalid request data
- `user_not_found` - User doesn't exist
- `user_exists` - User already exists (email conflict)
- `internal_error` - Server error

## 🔒 Best Practices Implemented

1. **Clean Architecture**: Separation of concerns with clear layers
2. **Dependency Injection**: Loose coupling between components
3. **Interface-based Design**: Repository and service interfaces
4. **Error Handling**: Consistent error responses and proper error wrapping
5. **Validation**: Input validation at handler level
6. **Configuration**: Environment-based configuration
7. **Database**: GORM with migrations and soft deletes
8. **Middleware**: Reusable middleware for cross-cutting concerns
9. **UUID**: Using UUIDs for primary keys for better security
10. **Pagination**: Built-in pagination support

## 🚧 Development

### Project Structure Explanation

- **`cmd/`**: Application entry points
- **`internal/`**: Private application code
  - **`config/`**: Configuration management
  - **`domain/`**: Business entities and DTOs
  - **`handlers/`**: HTTP request handlers
  - **`middleware/`**: HTTP middleware
  - **`repository/`**: Data access layer interfaces and implementations
  - **`service/`**: Business logic layer
- **`pkg/`**: Public library code that can be used by external applications
- **`migrations/`**: Database migration files

### Adding New Features

1. Define the domain model in `internal/domain/`
2. Create repository interface and implementation in `internal/repository/`
3. Implement business logic in `internal/service/`
4. Create HTTP handlers in `internal/handlers/`
5. Add routes in `internal/handlers/routes.go`
6. Update database migrations if needed

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support

If you have any questions or need help, please open an issue in the repository.

---

**Happy Coding! 🎉**
