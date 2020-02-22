# Lambda MLPerf

This is a repository to preproduce Lambda Labs' MLPerf results.


# Set Up

### Overall

- Ubuntu 18.04
- Lambda Stack (March 2019 with Nvidia Driver 418.88)
- MLNX_OFED_LINUX-4.4-1.0.0.0-ubuntu18.04-x86_64 
- nv_peer_mem


### Setup


```
# Update Lambda Stack
sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove
sudo apt-get install python3-dev
sudo apt install unzip
sudo apt install virtualenv

# Clone repo
cd
git clone https://github.com/lambdal/training_results_v0.6.git
cd training_results_v0.6

# Install nvidia-docker
cd NVIDIA/benchmarks
./install.sh

# Add user docker to sudo group
USER=ubuntu
sudo groupadd docker
sudo usermod -a -G docker $USER
sudo reboot

# Install OFED
cd
cd Downloads
wget http://www.mellanox.com/downloads/ofed/MLNX_OFED-4.4-1.0.0.0/MLNX_OFED_LINUX-4.4-1.0.0.0-ubuntu18.04-x86_64.tgz .
tar -xvf MLNX_OFED_LINUX-4.4-1.0.0.0-ubuntu18.04-x86_64.tgz
cd MLNX_OFED_LINUX-4.4-1.0.0.0-ubuntu18.04-x86_64
sudo ./mlnxofedinstall --force --add-kernel-support

# If there was an eror
cd /tmp/MLNX_OFED_LINUX-x.x-x.x..x-x.x.x-x-generic/MLNX_OFED_LINUX-x.x-x.x.x.x-ubuntu18.04-ext
sudo ./mlnxofedinstall --force

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

``` 

### Optimize Performance on Hyperplane

_Change kernel parameters_: 

1) Edit `/etc/default/grub` and add the following parameters to the line `GRUB_CMDLINE_LINUX`:

```
spectre_v2=off
transparent_hugepage=madvise
```

ex `GRUB_CMDLINE_LINUX="spectre_v2=off transparent_hugepage=madvise"`

2) `sudo update-grub`

3) `sudo reboot`

4) Verify the change with `cat /proc/cmdline`

_Change cpupower Setting_

```
sudo apt-get install -y linux-tools-$(uname -r)
sudo cpupower frequency-set -g performance
```

### Prepare Data

Copy `ILSVRC2012_img_train.tar` and `ILSVRC2012_img_val.tar` to `~/`

```
./prepare_data.sh
```

### Usage

Use this command to run all benchmarks

```
./run_mlperf.sh SYSTEM NUM_RUN 

# For examples:
./run_mlperf.sh LambdaHyperplane16 3
./run_mlperf.sh LambdaHyperplaneBasic 3
./run_mlperf.sh LambdaBlade2080Ti 3
./run_mlperf.sh LambdaQuad2080Ti 3
./run_mlperf.sh LambdaDual2080Ti 3
./run_mlperf.sh LambdaCloud4xQuadro5000 1 /data/training_results_v0.6/NVIDIA/benchmarks/data /data/training_results_v0.6/NVIDIA/benchmarks/logs
```

Multi-Node benchmark

* build docker images on individual nodes under the unprivileged account.


```
# SSD
docker build --pull -t mlperf-nvidia:single_stage_detector .

source config_2xLambdaHyperplaneBasic.sh && CONT="mlperf-nvidia:single_stage_detector" DATADIR=/home/chuan/training_results_v0.6/NVIDIA/benchmarks/data/mlperf/object_detection LOGDIR=/home/chuan/benchmarks/mlperf/single_stage_detector_2xLambdaHyperplaneBasic DGXSYSTEM=2xLambdaHyperplaneBasic srun -N $DGXNNODES -t $WALLTIME --ntasks-per-node $DGXNGPU run.sub

# MaskRCNN

docker build --pull -t mlperf-nvidia:object_detection .

source config_2xLambdaHyperplaneBasic.sh && CONT="mlperf-nvidia:object_detection" DATADIR=/home/chuan/training_results_v0.6/NVIDIA/benchmarks/data/mlperf/object_detection LOGDIR=/home/chuan/benchmarks/mlperf/maskrcnn_2xLambdaHyperplaneBasic DGXSYSTEM=2xLambdaHyperplaneBasic srun -N $DGXNNODES -t $WALLTIME run.sub

# ResNet
docker build --pull -t  mlperf-nvidia:image_classification .

source config_2xLambdaHyperplaneBasic.sh && CONT=mlperf-nvidia:image_classification DATADIR=/home/chuan/training_results_v0.6/NVIDIA/benchmarks/data/mlperf/imagenet-mxnet LOGDIR=/home/chuan/benchmarks/mlperf/resnet_2xLambdaHyperplaneBasic DGXSYSTEM=2xLambdaHyperplaneBasic srun -N $DGXNNODES -t $WALLTIME run.sub

```

* Run data preparation on a COMPUTING node (because CUDA is needed)

```
./prepare_data.sh
```

* Restart compute nodes on a SLURM cluster

```
sudo scontrol update nodename=4029gp-tvrt-[0-1] state=down reason=hang
sudo scontrol update nodename=4029gp-tvrt-[0-1] state=resume
```



To compile statistics, run this command with the correct `SYSTEM`, `PATH_RESULTS` and `FORMAT` settings:

```
python gather_results.py
```

Check individual benchmark folders for more details.

### Results


__Training Throughput (The higher the better)__


|   | ssd (samples/sec) | maskrcnn (iterations/s) | resnet (samples/sec) | gnmt (Tok/s) | translation (batches/sec) | minigo (epochs/min) |
|---|---|---|---|---|---|---|
| 2 x Lambda HyperPlane Basic | 8310.40 |  |  |  |  |  |
| DGX2 Reference | 8274.91 | 272.97 | 22361.42 | 1349928.90 | 84.86 | x |
| Lambda Hyper plane16+cpupower | 8264.94 | 268.12 | 21879.38 | 1336200.98 | 84.09 | x |
| Lambda Hyper plane16 | 8040.79 | 257.07 | 21767.38 | 1313706.02 | 83.47 | x |
| DGX1 Reference  | 4420.04  | 132.2  | 11224  |  727808 | 33.82  | 0.61  |
| Lambda HyperPlane Basic+cpupower | 4273.94  | 139.65  | 10403.22  | 705040.75  | 40.04  |  0.66 |
| Lambda HyperPlane Basic | 4280.86  | 133.20  | 10861.43  | 696587.86  | 33.77  |  0.50 |
| Lambda Blade 2080Ti | 2575.92  | 72.86  | 6301.29  | 326569.0  | 26.68  |  0.30 |
| Lambda Quad 2080Ti | 1096.60 | 35.70 | 2739.52 | 147396.0 | 13.12 | 0.15 |
| Lambda Dual 2080Ti | 593.10 | x | 1455.81 | 86146.37 | 10.31 | x |


__Minutes to Solution (The lower the better)__

|   | ssd  | maskrcnn  | resnet  | gnmt  | translation  | minigo  |
|---|---|---|---|---|---|---|
| 2 x Lambda HyperPlane Basic |  |  |  |  |  |  |
| DGX2 Reference | 13.32 | 108.02 | 59.8 | 12.23 | 11.62 | x |
| Lambda Hyper plane16+cpupower | 12.62 | 106.15 | 60.37 | 13.40 | 11.27 | x |
| Lambda Hyper plane16 | 14.05 | 109.01 | 61.48 | 12.97 | 13.01 | x |
| DGX1 Reference  | 22.03  | 207.48  | 115.22  |  20.55 | 20.34  | 27.39  |
| Lambda HyperPlane Basic+cpupower | 23.17  | 197.06  | 124.82  | 21.37  | 23.19  |  24.82 |
| Lambda HyperPlane Basic | 23.33  | 206.82  | 117.21  | 23.50  | 19.85  |  29.76 |
| Lambda Blade 2080Ti | 38.25  | 586.66  | 206.2  | 45.03  | 66.45  |  51.23 |
| Lambda Quad 2080Ti | 88.31 | 598.2 | 501.35 | 124.16 | 100.86 | 143.15 |
| Lambda Dual 2080Ti | 162.95 | x | 1001.5 | 338.68 | 259.29 | x |


* Training Throughtput is a fairer metric as the training may take different numbers of epochs to reach the solution due to random initialization and data shuffling.
* The DGX1 and DGX2 use different `MAX_TOKENS` for the `translation` task (10240 v.s. 8192), which makes the throughput comparison unfair (the speed up of DGX2 is 2.50). We correct this for compairing `LambdaHyperplaneBasic+cpupower` and `LambdaHyperplane16+cpupower` (use 8192 for both) and get a more reasonable speedup factor (2.1). 
