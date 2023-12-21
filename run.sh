#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [--master | --worker]"
  exit 1
fi

node=$1

echo "Install Kubernetes"
sudo sh src/master.sh
mv src/config/containerd.toml /etc/containerd/config.toml
systemctl daemon-reload

if [ "$node" == "--master" ];then
  # Init Master node
  echo "Init Master node"
  sudo kubeadm config images pull --image-repository=registry.aliyuncs.com/google_containers
  kubeadm init \
    --apiserver-advertise-address=192.168.56.10 \
    --image-repository=registry.aliyuncs.com/google_containers \
    --kubernetes-version=v1.28.3 \
    --pod-network-cidr=10.244.0.0/16 \
    --ignore-preflight-errors=all
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  source <(kubectl completion bash)

  # Install Calico
  kubectl apply -f src/config/calico.yaml

elif [ "$node" == "--worker" ];then
  echo "Init Worker node"
else
  echo "Invalid node type. Use --master or --worker."
  exit 1
fi
