# Prometheus
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.31.1/prometheus-2.31.1.linux-amd64.tar.gz
sudo tar prometheus-2.31.1.linux-amd64.tar.gz
# Скопируйте исполняемые файлы в /usr/local/bin/:
cd prometheus-2.20.1.linux-amd64/
cp prometheus /usr/local/bin/
cp promtool /usr/local/bin/
# Создайте папку для файлов конфигурации и скопируйте в неё конфиги:
cp -r consoles/ /etc/prometheus/consoles/
cp -r console_libraries/ /etc/prometheus/console_libraries/
cp prometheus.yml /etc/prometheus/
# Создайте папку для хранения данных:
mkdir /var/lib/prometheus
# Создайте пользователя и назначьте владельца файлов и папок:
useradd -M -r -s /bin/nologin prometheus
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
# Создайте systemd-юнит, чтобы удобнее управлять сервисом:
cat /etc/systemd/system/prometheus.service << EOF
[Unit]
Description=Prometheus systemd service unit
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/prometheus \
--config.file=/etc/prometheus/prometheus.yml \
--storage.tsdb.path=/var/lib/prometheus \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries \
--web.listen-address=0.0.0.0:9090

SyslogIdentifier=prometheus
Restart=always
[Install]
WantedBy=multi-user.target
EOF

sudo cat >> /etc/prometheus/prometheus.yml <<EOF
  - job_name: 'backends'
    static_configs:
      - targets: ['18.188.170.28:9100', '18.190.157.246:9100', '18.117.114.211:9100']
  - job_name: 'requests'
    static_configs:
      - targets: ['18.188.170.28:5000', '18.190.157.246:5000', '18.117.114.211:5000']
EOF

systemctl daemon-reload
systemctl start prometheus.service
systemctl enable prometheus.service
