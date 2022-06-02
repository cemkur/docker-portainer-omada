sudo apt update
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

sudo apt update
sudo apt install docker-compose docker-compose-plugin -y

read -p "Press [Enter] key to check docker compose version..."
docker compose version
read -p "Press [Enter] key to start portainer installation..."

cd /opt/portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.11.1

read -p "Press [Enter] key to start omada installation..."

cd /opt/omada
wget https://raw.githubusercontent.com/mbentley/docker-omada-controller/master/docker-compose.yml
read -p "Press [Enter] key to edit docker-compose - replace 5.1 with latest-amd64 ..."
nano docker-compose.yml
read -p "Press [Enter] key to start omada docker image..."
docker-compose up -d
