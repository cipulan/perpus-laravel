FROM php:7.4-fpm

ENV APP_DIR="/var/www"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
# RUN useradd -G www-data,root -u $uid /home/$user $user
# RUN mkdir -p /home/$user/.composer && \
#    chown -R $user:$user /home/$user

COPY ./perpus-laravel $APP_DIR
COPY ./perpus-laravel/.env.example $APP_DIR/.env

RUN cd $APP_DIR && composer update
RUN cd $APP_DIR && php artisan key:generate
# RUN cd $APP_DIR && php artisan migrate
# RUN cd $APP_DIR && php artisan db:seed

# Set working directory
WORKDIR $APP_DIR
CMD php artisan serve --host=0.0.0.0 --port=8000

EXPOSE 8000
# USER $user
