sudo apt update
sudo apt upgrade -y
sudo apt install curl apt-transport-https ca-certificates software-properties-common -y
curl -fsSL https://apt.ollama.io/gpg | sudo tee /etc/apt/trusted.gpg.d/ollama.asc
echo "deb [arch=amd64] https://apt.ollama.io stable main" | sudo tee /etc/apt/sources.list.d/ollama.list
sudo apt update
sudo apt install ollama -y
ollama --version
