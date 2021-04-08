cd ~

echo Updanting Raspbian
sudo apt-get update
sudo apt-get upgrade -y


echo Installing ais_JSON
sudo apt-get install python-pip -y
git clone https://github.com/mikaelpfonseca/ais_json
pip install requests
pip install libais
pip install termcolor


echo Creating and enabling a AIS_JSON service
sleep 2
sudo /bin/sh -c 'cat > /etc/systemd/system/ais_JSON.service <<\EOF
[Unit]
Description=AIS JSON Encode
After=network.target
[Service]
ExecStart= /usr/bin/python /home/pi/ais_json/ais_json.py
WorkingDirectory=/home/pi
StandardOutput=inherit
StandardError=inherit
Restart=always
User=pi
[Install]
WantedBy=multi-user.target
EOF'

sudo chmod 777 /etc/systemd/system/ais_JSON.service

sudo systemctl enable ais_JSON.service
sudo reboot
