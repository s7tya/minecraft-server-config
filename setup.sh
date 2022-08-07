#!/bin/bash

# Minecraft version
MINECRAFT_VERSION="1.19.2"

# Create swap
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
cp /etc/fstab /etc/fstab.backup
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Install Corretto
wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add - 
add-apt-repository 'deb https://apt.corretto.aws stable main'
apt-get update; sudo apt-get install -y java-17-amazon-corretto-jdk

# Install jq
apt install -y jq

mkdir /opt/minecraft
cd /opt/minecraft

# Download Paper MC
BUILD_NUMBER=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION}/builds" | jq '.builds[0].build')

curl -so paper.jar https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION}/builds/${BUILD_NUMBER}/downloads/paper-${MINECRAFT_VERSION}-${BUILD_NUMBER}.jar

# Create launcher
cat <<EOS > launcher.sh
#!/bin/bash
java -Xms2G -Xmx2G -jar /opt/minecraftpaper.jar --nogui
EOS

# Launch
chown -R ubuntu:ubuntu /opt/minecraft
chmod +x launcher.sh
sh ./launch.sh

# Agree to the eula
echo "eula=true" > eula.txt

cat <<EOS > /lib/systemd/system/minecraft.service
[Unit]
Description=minecraft

[Service]
Type=simple
User=ubuntu
Group=ubuntu
WorkingDirectory=/opt/minecraft
ExecStart=/opt/minecraftlauncher.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOS

systemctl enable minecraft
systemctl start minecraft