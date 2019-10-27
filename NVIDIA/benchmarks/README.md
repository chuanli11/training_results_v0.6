# Lambda MLPerf

This is a repository to preproduce Lambda Labs' MLPerf results.


# Set Up

### Overall

- Ubuntu 18.04
- Lambda Stack (March 2019 with Nvidia Driver 418.88)
- MLNX_OFED_LINUX-4.4-1.0.0.0-ubuntu18.04-x86_64 
- nv_peer_mem


### Procedure


```
# Update Lambda Stack
sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove

# Clone repo
cd
git clone https://github.com/chuanli11/training_results_v0.6.git
cd training_results_v0.6

# Install nvidia-docker
./install.sh

# Add user docker to sudo group
USER=ubuntu
sudo groupadd docker
sudo usermod -a -G docker $USER
sudo reboot

# Install OFED
cd Downloads
wget http://www.mellanox.com/downloads/ofed/MLNX_OFED-4.4-1.0.0.0/MLNX_OFED_LINUX-4.4-1.0.0.0-ubuntu18.04-x86_64.tgz .
tar -xvf MLNX_OFED_LINUX-4.4-1.0.0.0-ubuntu18.04-x86_64.tgz
cd MLNX_OFED_LINUX-4.4-1.0.0.0-ubuntu18.04-x86_64
sudo ./mlnxofedinstall --force --add-kernel-support
sudo /etc/init.d/openibd restart

# Install nv_peer_memory
cd
git clone https://github.com/Mellanox/nv_peer_memory.git
cd nv_peer_memory

./build_module.sh

cd /tmp
tar xzf /tmp/nvidia-peer-memory_1.0.orig.tar.gz
cd nvidia-peer-memory-1.0
dpkg-buildpackage -us -uc

cd ..
mv nvidia-peer-memory-dkms_1.0-8_all.deb ~/
mv nvidia-peer-memory_1.0-8_all.deb ~/

cd
sudo dpkg -i nvidia-peer-memory-dkms_1.0-8_all.deb
sudo dpkg -i nvidia-peer-memory_1.0-8_all.deb
lsmod | grep peer

sudo apt-get install python3-dev
``` 

