# Grafana
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_8.3.1_amd64.deb
sudo apt install ./grafana-enterprise_8.3.1_amd64.deb
sudo systemctl start grafana-server
sudo systemctl status grafana-server
sudo systemctl enable grafana-server
