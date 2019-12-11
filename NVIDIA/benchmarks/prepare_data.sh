#!/bin/bash

## -----------------------------------------
## resnet
## -----------------------------------------
#FILE_TRAIN="/home/$USER/ILSVRC2012_img_train.tar"
#FILE_VAL="/home/$USER/ILSVRC2012_img_val.tar"
#
#if test -f "$FILE_TRAIN"; then
#    echo "$FILE_TRAIN exist"
#else
#	echo "$FILE_TRAIN does not exist"
#	exit
#fi
#
#if test -f "$FILE_VAL"; then
#    echo "$FILE_VAL exist"
#else
#	echo "$FILE_VAL does not exist"
#	exit  
#fi
#
#pushd .
#
#cd
#
#virtualenv -p /usr/bin/python3.6 venv-mxnet
#. venv-mxnet/bin/activate
#pip install opencv-python mxnet
#
#mkdir -p ~/data/mlperf/imagenet-mxnet/val-jpeg
#tar -vxf ILSVRC2012_img_val.tar -C ~/data/mlperf/imagenet-mxnet/val-jpeg
#
#pushd .
#cd ~/data/mlperf/imagenet-mxnet/val-jpeg
#wget -qO- https://raw.githubusercontent.com/soumith/imagenetloader.torch/master/valprep.sh | bash
#
#mkdir -p ~/data/mlperf/imagenet-mxnet/train-jpeg
#mkdir -p ~/data/mlperf/imagenet-mxnet/train-tar
#
#popd
#
#tar -vxf ILSVRC2012_img_train.tar -C ~/data/mlperf/imagenet-mxnet/train-tar
#for filename in /home/$USER/data/mlperf/imagenet-mxnet/train-tar/*.tar; do
#        outputname="/home/$USER/data/mlperf/imagenet-mxnet/train-jpeg/$(basename "$filename" .tar)"
#        mkdir -p $outputname
#        tar -vxf $filename -C $outputname
#done
#
#python /home/$USER/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --list --recursive train /home/$USER/data/mlperf/imagenet-mxnet/train-jpeg
#
#python /home/$USER/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --list --recursive val /home/$USER/data/mlperf/imagenet-mxnet/val-jpeg
#
#python /home/$USER/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --pass-through --num-thread 20 train /home/$USER/data/mlperf/imagenet-mxnet/train-jpeg
#
#python /home/$USER/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --pass-through --num-thread 20 val /home/$USER/data/mlperf/imagenet-mxnet/val-jpeg
#
#
#mv /home/$USER/train.idx /home/$USER/data/mlperf/imagenet-mxnet
#mv /home/$USER/train.rec /home/$USER/data/mlperf/imagenet-mxnet
#mv /home/$USER/train.lst /home/$USER/data/mlperf/imagenet-mxnet
#
#mv /home/$USER/val.idx /home/$USER/data/mlperf/imagenet-mxnet
#mv /home/$USER/val.rec /home/$USER/data/mlperf/imagenet-mxnet
#mv /home/$USER/val.lst /home/$USER/data/mlperf/imagenet-mxnet
#
#deactivate
#
#popd

# -----------------------------------------
# ssd and maskrcnn
# -----------------------------------------
./ssd/implementations/pytorch/download_dataset.sh

# -----------------------------------------
# maskrcnn
# -----------------------------------------
./maskrcnn/implementations/download_weights.sh

# -----------------------------------------
# gnmt
# -----------------------------------------
pushd .
cd gnmt/implementations
./download_dataset.sh "/home/$USER/data/mlperf/rnn_translator"
popd

# -----------------------------------------
# transformer
# -----------------------------------------
pushd .
cd transformer/implementations/pytorch/data_preparation

virtualenv -p /usr/bin/python3.6 venv-compile
. venv-compile/bin/activate
pip install torch==1.0.0 torchvision==0.2.2
python setup.py install
pip install mlperf_compliance==0.0.6

./run_preprocessing.sh

cp build/lib.linux-x86_64-3.6/fairseq/data/*.so fairseq/data/
cp build/lib.linux-x86_64-3.6/fairseq/data/*.py fairseq/data/

./run_conversion.sh
deactivate
rm -rf build
rm fairseq/data/*.so

popd
