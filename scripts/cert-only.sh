pwd
docker run -it --rm --name certbot --mount src=$(pwd)/../le/certs,target=/etc/letsencrypt,type=bind --mount src=$(pwd)/../le/data,target=/webroot,type=bind certbot/certbot certonly --webroot --webroot-path="/webroot"
