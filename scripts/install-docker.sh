#!/bin/bash
export DEBIAN_FRONTEND=noninteractive 
sudo apt-get update \
    && sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && sudo add-apt-repository \
        "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
        $(lsb_release -cs) \
        stable" \
    && sudo apt-get update \
    && sudo apt-get install containerd.io=1.2.13-2 \
    && sudo apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 18.09 | head -1 | awk '{print $3}')

cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo mkdir -p /etc/systemd/system/docker.service.d

sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker