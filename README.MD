# Laravel Docker

```
docker network create laravel
docker run -d --name db -p 3306 --network laravel -v ./db:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=rahasia -e MYSQL_DATABASE=perpusku_gc -e MYSQL_USER=homestead -e MYSQL_PASSWORD=secret mysql:5.7
docker run -d --name perpus-cipulan --network laravel -p 8000:8000 img-perpus-cipulan:latest
```

```
php artisan migrate
php artisan db:seed
```

