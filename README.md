# alpine-mariadb

Une image docker de MariaDB basée sur alpine linux

# build image
```bash
docker build -t tvoyat/alpine-mariadb .
docker run -it --rm -v $(pwd):/var/lib/mysql -p 3306:3306 tvoyat/alpine-mariadb
```

# Usage

Par défaut, le mot de passe 'root' de mariadb est 'mariadb' et aucune base n'est présente.

```bash
docker run -d --name mariadb -p 3306:3306 tvoyat/alpine-mariadb
```


Avec un volume local, un mot de passe différent et création d'une base :

```bash
docker run -d --name mariadb -p 3306:3306 \
    -v $(pwd)/data:/var/lib/mysql \
    -e DATABASE=base -e USER=pfrate -e PASSWORD=password \
    -e ROOT_PASSWORD=monpassword tvoyat/alpine-mariadb
```
