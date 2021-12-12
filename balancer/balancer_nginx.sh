# Nginx
#sudo apt update
#sudo apt install nginx
#
#sudo ufw allow 'Nginx HTTP' #  настройка программного обеспечения брандмауэра, чтобы разрешить доступ к службе. этот профиль открывает только порт 80
#sudo ufw status
sudo amazon-linux-extras install nginx1.12 -y

#systemctl status nginx
sudo cat nginx.conf > ../../etc/nginx/nginx.conf

sudo systemctl reload nginx
