# alpine-mariadb

Une image docker de MariaDB basée sur alpine linux

# build image
```
docker build -t tvoyat/alpine-mariadb .
docker run -it --rm -v $(pwd):/var/lib/mysql -p 3306:3306 tvoyat/alpine-mariadb
```

# Usage
```
docker run -idt --name mariadb -p 3306:3306 \
    -v $(pwd)/data:/var/lib/mysql \
    -e DATABASE=base -e USER=pfrate -e PASSWORD=password \
    -e ROOT_PASSWORD=mariadb tvoyat/alpine-mariadb
```

Le mot de passe par défaut est "mariadb"
