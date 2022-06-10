mkdir /opt/portainer
mkdir /opt/omada
mkdir /opt/scripts
sudo apt update
#read -p "Press [Enter] key to continue..."
sudo apt install ca-certificates curl gnupg lsb-release
#read -p "Press [Enter] key to continue..."
sudo mkdir -p /etc/apt/keyrings
#read -p "Press [Enter] key to continue..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#read -p "Press [Enter] key to continue..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#read -p "Press [Enter] key to continue..."
sudo apt update
#read -p "Press [Enter] key to continue..."
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
#read -p "Press [Enter] key to continue..."
sudo apt update
#read -p "Press [Enter] key to continue..."
sudo apt install docker-compose docker-compose-plugin -y

#read -p "Press [Enter] key to check docker compose version..."
docker compose version
#read -p "Press [Enter] key to start portainer installation..."

cd /opt/portainer
#read -p "Press [Enter] key to continue..."
docker volume create portainer_data
#read -p "Press [Enter] key to continue..."
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.11.1

#read -p "Press [Enter] key to start omada installation..."

cd /opt/omada
#read -p "Press [Enter] key to continue..."
wget https://raw.githubusercontent.com/mbentley/docker-omada-controller/master/docker-compose.yml
read -p "Press [Enter] key to edit docker-compose - replace 5.1 with latest-amd64 ..."
nano docker-compose.yml
read -p "Press [Enter] key to start omada docker image..."
docker-compose up -d
docker ps
