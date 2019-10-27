### Prepare Data

```
cd
virtualenv -p /usr/bin/python3.6 venv-mxnet
. venv-mxnet/bin/activate
pip install opencv-python mxnet


mkdir -p ~/data/mlperf/imagenet-mxnet/val-jpeg
tar -vxf ILSVRC2012_img_val.tar -C ~/data/mlperf/imagenet-mxnet/val-jpeg

# https://github.com/NVIDIA/DeepLearningExamples/issues/144
cd ~/data/mlperf/imagenet-mxnet/val-jpeg
wget -qO- https://raw.githubusercontent.com/soumith/imagenetloader.torch/master/valprep.sh | bash

mkdir -p ~/data/mlperf/imagenet-mxnet/train-jpeg
mkdir -p ~/data/mlperf/imagenet-mxnet/train-tar

cd
tar -vxf ILSVRC2012_img_train.tar -C ~/data/mlperf/imagenet-mxnet/train-tar

for filename in /home/ubuntu/data/mlperf/imagenet-mxnet/train-tar/*.tar; do
        #echo $filename
        #echo $(basename "$filename" .tar)
        outputname="/home/ubuntu/data/mlperf/imagenet-mxnet/train-jpeg/$(basename "$filename" .tar)"
        mkdir -p $outputname
        tar -vxf $filename -C $outputname
done

python /home/ubuntu/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --list --recursive train /home/ubuntu/data/mlperf/imagenet-mxnet/train-jpeg

python /home/ubuntu/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --list --recursive val /home/ubuntu/data/mlperf/imagenet-mxnet/val-jpeg

python /home/ubuntu/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --pass-through --num-thread 20 train /home/ubuntu/data/mlperf/imagenet-mxnet/train-jpeg

python /home/ubuntu/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --pass-through --num-thread 20 val /home/ubuntu/data/mlperf/imagenet-mxnet/val-jpeg

mv /home/ubuntu/train.idx /home/ubuntu/data/mlperf/imagenet-mxnet
mv /home/ubuntu/train.rec /home/ubuntu/data/mlperf/imagenet-mxnet
mv /home/ubuntu/train.lst /home/ubuntu/data/mlperf/imagenet-mxnet

mv /home/ubuntu/val.idx /home/ubuntu/data/mlperf/imagenet-mxnet
mv /home/ubuntu/val.rec /home/ubuntu/data/mlperf/imagenet-mxnet
mv /home/ubuntu/val.lst /home/ubuntu/data/mlperf/imagenet-mxnet

```


### Build Docker Image

```
docker build --pull -t  mlperf-nvidia:image_classification .
```


### Run Benchmark

```
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/imagenet-mxnet LOGDIR=/home/ubuntu/benchmarks/mlperf/resnet-mxnet DGXSYSTEM=LambdaDualBasic ./run.sub

NEXP=3 DATADIR=/home/ubuntu/data/mlperf/imagenet-mxnet LOGDIR=/home/ubuntu/benchmarks/mlperf/resnet-mxnet DGXSYSTEM=DGX1 ./run.sub
```
