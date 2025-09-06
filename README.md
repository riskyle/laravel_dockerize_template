# Laravel Docker Template

<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

A ready-to-use Laravel development template with Docker, PostgreSQL, and Nginx. Perfect for quickly spinning up new Laravel projects with a complete development environment.

## 🚀 Features

-   **Laravel 12** - Latest version of the Laravel framework
-   **Docker & Docker Compose** - Containerized development environment
-   **PostgreSQL 17** - Modern, powerful database with Alpine Linux
-   **Nginx** - High-performance web server and reverse proxy
-   **PHP 8.2-FPM** - Latest stable PHP with FastCGI Process Manager
-   **Composer** - Dependency management pre-configured
-   **Volume Management** - Optimized for development with live code reloading

## 📋 Requirements

-   Docker
-   Docker Compose
-   Git

## 🛠️ Quick Start

1. **Clone this template:**

    ```bash
    git clone <your-repo-url> my-new-project
    cd my-new-project
    ```

2. **Copy environment file:**

    ```bash
    cp .env.example .env
    ```

3. **Build and start the containers:**

    ```bash
    docker-compose up -d --build
    ```

4. **Generate application key:**

    ```bash
    docker-compose exec app php artisan key:generate
    ```

5. **Run migrations:**
    ```bash
    docker-compose exec app php artisan migrate
    ```

## 🏗️ Project Structure

```
├── app/                    # Laravel application code
├── docker-compose.yml      # Docker services configuration
├── Dockerfile             # PHP-FPM container definition
├── nginx/                 # Nginx configuration
│   └── conf.d/
│       └── default.conf   # Server block configuration
├── php/                   # PHP configuration
│   └── local.ini          # Custom PHP settings
└── docker-data/           # Database initialization scripts
    └── init/
        └── pgsql/
```

## �️ Database Access

### Command Line Access

```bash
# Access PostgreSQL CLI directly
docker-compose exec pgsql psql -U laravel -d laravel_dockerize_template

# Or connect from host machine (if you have psql installed)
psql -h localhost -p 5432 -U laravel -d laravel_dockerize_template
```

### GUI Access with pgAdmin

This template includes pgAdmin for web-based PostgreSQL administration:

**Access pgAdmin:**

-   URL: `http://localhost:8080`
-   Email: `admin@example.com`
-   Password: `admin`

**Start pgAdmin:**

```bash
docker-compose up -d pgadmin
```

**Connect to PostgreSQL in pgAdmin:**

-   Host: `pgsql` (container name)
-   Port: `5432`
-   Database: `laravel_dockerize_template`
-   Username: `laravel`
-   Password: `password`

### Alternative Database Tools

**Desktop Applications:**

-   **pgAdmin** - Official PostgreSQL administration tool
-   **DBeaver** - Universal database tool (free)
-   **DataGrip** - JetBrains database IDE (paid)
-   **TablePlus** - Modern database client (paid)

**VS Code Extensions:**

-   **PostgreSQL** by Chris Kolkman
-   **Database Client** by Weijan Chen

## �🔧 Services

### Application (PHP-FPM)

-   **Port:** 9000 (internal)
-   **Environment:** Development-optimized
-   **Volume:** Project files mounted for live reloading

### Database (PostgreSQL)

-   **Port:** 5432 (configurable via `FORWARD_DB_PORT`)
-   **Database:** `laravel_dockerize_template` (configurable via `DB_DATABASE`)
-   **User:** `laravel` (configurable via `DB_USERNAME`)
-   **Password:** `password` (configurable via `DB_PASSWORD`)

### Web Server (Nginx)

-   **Port:** 80 (configurable via `FORWARD_NGINX_PORT`)
-   **SSL Port:** 443 (configurable via `FORWARD_NGINX_SSL_PORT`)
-   **Document Root:** `/var/www/public`

## ⚙️ Configuration

### Environment Variables

Create a `.env` file from `.env.example` and customize:

```env
# Database Configuration
DB_CONNECTION=pgsql
DB_HOST=pgsql
DB_PORT=5432
DB_DATABASE=laravel_dockerize_template
DB_USERNAME=laravel
DB_PASSWORD=password

# Port Forwarding (Optional)
FORWARD_DB_PORT=5432
FORWARD_NGINX_PORT=80
FORWARD_NGINX_SSL_PORT=443
```

## 🐳 Docker Commands

### Container Management

```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# Rebuild containers (after Dockerfile changes)
docker-compose up -d --build

# View container logs
docker-compose logs -f [service-name]
```

### Laravel Commands

```bash
# Run Artisan commands
docker-compose exec app php artisan [command]

# Install Composer dependencies
docker-compose exec app composer install

# Run database migrations
docker-compose exec app php artisan migrate

# Generate application key
docker-compose exec app php artisan key:generate

# Clear caches
docker-compose exec app php artisan cache:clear
docker-compose exec app php artisan config:clear
docker-compose exec app php artisan view:clear
```

### Database Management

```bash
# Access PostgreSQL CLI
docker-compose exec pgsql psql -U laravel -d laravel_dockerize_template

# Create database backup
docker-compose exec pgsql pg_dump -U laravel laravel_dockerize_template > backup.sql

# Restore database backup
docker-compose exec -T pgsql psql -U laravel -d laravel_dockerize_template < backup.sql

# Start pgAdmin (if added to docker-compose.yml)
docker-compose up -d pgadmin

# View database container logs
docker-compose logs -f pgsql
```

## 🔧 Customization

### Adding PHP Extensions

Edit the `Dockerfile` and add extensions:

```dockerfile
RUN docker-php-ext-install extension_name
```

### Nginx Configuration

Modify `nginx/conf.d/default.conf` for custom server configurations.

### PHP Configuration

Edit `php/local.ini` for custom PHP settings like memory limits, upload sizes, etc.

## 🚨 Troubleshooting

### Common Issues

**Vendor directory not found:**

```bash
docker-compose exec app composer install
```

**Permission issues:**

```bash
docker-compose exec app chown -R www:www /var/www
docker-compose exec app chmod -R 755 /var/www
```

**Database connection refused:**

-   Ensure PostgreSQL container is healthy: `docker-compose ps`
-   Check database credentials in `.env`
-   Wait for database initialization on first run

**Port conflicts:**

-   Change ports in `.env` file using `FORWARD_*_PORT` variables
-   Ensure no other services are using the same ports

## 📝 Development Tips

1. **Live Reloading:** Your code changes are automatically reflected (no container restart needed)
2. **Database Persistence:** Database data persists between container restarts
3. **Environment Variables:** Use `.env` file for configuration management
4. **Logs:** Monitor application logs with `docker-compose logs -f app`

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This template is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

---

**Happy coding! 🎉**
