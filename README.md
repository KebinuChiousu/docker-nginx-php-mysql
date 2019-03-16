# WordPress MySQL php mysqladmin

Docker running a nginx, wordpress:fpm, MySQL and PHPMyAdmin.

## Overview

1. [Install prerequisites](#install-prerequisites)

    Before installing project make sure the following prerequisites have been met.

2. [Clone the project](#clone-the-project)

    We’ll download the code from its repository on GitHub.

3. [Use Makefile](#use-makefile)

    When developing, you can use `Makefile` for doing recurrent operations.

___

## Install prerequisites

For now, this project has been mainly created for Unix `(Linux/MacOS)`. Perhaps it could work on Windows.

All requisites should be available for your distribution. The most important are :

* [Git](https://git-scm.com/downloads)
* [Docker](https://docs.docker.com/engine/installation/)
* [Docker Compose](https://docs.docker.com/compose/install/)

Check if `docker-compose` is already installed by entering the following command : 

```sh
which docker-compose
```

Check Docker Compose compatibility :

* [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/)

Check if `make`  is already installed by entering the following command : 

```sh
which make
```

On Ubuntu and Debian these are available in the meta-package build-essential. On other distributions, you may need to install the GNU C++ compiler separately.

```sh
sudo apt install build-essential
```

### Images to use

* [Nginx](https://hub.docker.com/_/nginx/)
* [WordPress](https://hub.docker.com/_/wordpress/)
* [MySQL](https://hub.docker.com/_/mysql/)
* [PHPMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)
* [CertBot](https://hub.docker.com/r/certbot/certbot/)
* [Generate Certificate](https://hub.docker.com/r/jacoelho/generate-certificate)

You should be careful when installing third party web servers such as MySQL or Nginx.

This project use the following ports :

| Server     |  Port  |
|------------|--------|
| MySQL      | 8989   |
| PHPMyAdmin | 8889   |
| Nginx      | 80/443 |
|------------|--------|
___

## Clone the project

To install [Git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git), download it and install following the instructions :

```sh
git clone https://github.com/KebinuChiousu/docker-nginx-php-mysql.git
```

Go to the project directory :

```sh
cd docker-nginx-php-mysql
```

### Project tree

```sh
.
├── Makefile
├── README.md
├── data
│   └── db
│       ├── dumps
│       └── mysql
├── doc
└── docker-compose.yml

1. Start the application :

    ```sh
    sudo docker-compose up -d
    ```

    **Please wait this might take a several minutes...**

    ```sh
    sudo docker-compose logs -f # Follow log output
    ```

2. Open your favorite browser :

    * [http://localhost:8888](http://localhost:8888/)
    * [http://localhost:8889](http://localhost:8889/) PHPMyAdmin (username: dev, password: dev)

3. Stop and clear services

    ```sh
    sudo docker-compose down -v
    ```

___

## Use Makefile

When developing, you can use [Makefile](https://en.wikipedia.org/wiki/Make_(software)) for doing the following operations :

| Name          | Description                                  |
|---------------|----------------------------------------------|
| clean         | Clean directories for reset                  |
| docker-start  | Create and start containers                  |
| docker-stop   | Stop and clear all services                  |
| logs          | Follow log output                            |
| mysql-cli     | Acess MySQL cli                              |
| mysql-dump    | Create backup of all databases               |
| mysql-restore | Restore backup of all databases              |

### Examples

Start the application :

```sh
sudo make docker-start
```

Show help :

```sh
make help
```

___

### Handling database

#### MySQL shell access

```sh
sudo docker exec -it mysql bash
```

and

```sh
mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD"
```

#### Creating a backup of all databases

```sh
mkdir -p data/db/dumps
```

```sh
source .env && sudo docker exec $(sudo docker-compose ps -q mysqldb) mysqldump --all-databases -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" > "data/db/dumps/db.sql"
```

#### Restoring a backup of all databases

```sh
source .env && sudo docker exec -i $(sudo docker-compose ps -q mysqldb) mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" < "data/db/dumps/db.sql"
```

#### Creating a backup of single database

**`Notice:`** Replace "YOUR_DB_NAME" by your custom name.

```sh
source .env && sudo docker exec $(sudo docker-compose ps -q mysqldb) mysqldump -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" --databases YOUR_DB_NAME > "data/db/dumps/YOUR_DB_NAME_dump.sql"
```

#### Restoring a backup of single database

```sh
source .env && sudo docker exec -i $(sudo docker-compose ps -q mysqldb) mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" < "data/db/dumps/YOUR_DB_NAME_dump.sql"
```
