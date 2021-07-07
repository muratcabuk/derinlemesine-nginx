cp -a /etc/nginx /etc/nginx-plus-backup
cp -a /var/log/nginx /var/log/nginx-plus-backup

mkdir /etc/ssl/nginx
cd /etc/ssl/nginx

cp nginx-repo.crt /etc/ssl/nginx/
cp nginx-repo.key /etc/ssl/nginx/

wget https://cs.nginx.com/static/keys/nginx_signing.key && apt-key add nginx_signing.key
wget https://cs.nginx.com/static/keys/app-protect-security-updates.key && apt-key add app-protect-security-updates.key

apt-get install apt-transport-https lsb-release ca-certificates

printf "deb https://pkgs.nginx.com/plus/ubuntu `lsb_release -cs` nginx-plus\n" | tee /etc/apt/sources.list.d/nginx-plus.list

printf "deb https://pkgs.nginx.com/app-protect/ubuntu `lsb_release -cs` nginx-plus\n" | tee /etc/apt/sources.list.d/nginx-app-protect.list

printf "deb https://pkgs.nginx.com/app-protect-security-updates/ubuntu `lsb_release -cs` nginx-plus\n" | tee -a /etc/apt/sources.list.d/nginx-app-protect.list

printf "deb https://pkgs.nginx.com/modsecurity/ubuntu `lsb_release -cs` nginx-plus\n" | tee /etc/apt/sources.list.d/nginx-modsecurity.list

wget -P /etc/apt/apt.conf.d https://cs.nginx.com/static/files/90pkgs-nginx

apt-get update

apt-get install -y nginx-plus

apt-get install app-protect app-protect-attack-signatures

apt-get install nginx-plus nginx-plus-module-modsecurity

nginx -v
