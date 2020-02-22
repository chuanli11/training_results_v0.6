#!/bin/bash

DIR_ROOT=$(pwd)

# -----------------------------------------
# resnet
# -----------------------------------------
FILE_TRAIN="${DIR_ROOT}/data/ILSVRC2012_img_train.tar"
FILE_VAL="${DIR_ROOT}/data/ILSVRC2012_img_val.tar"

if test -f "$FILE_TRAIN"; then
    echo "$FILE_TRAIN exist"
else
	echo "$FILE_TRAIN does not exist"
	exit
fi

if test -f "$FILE_VAL"; then
    echo "$FILE_VAL exist"
else
	echo "$FILE_VAL does not exist"
	exit  
fi

pushd .

cd ${DIR_ROOT}

virtualenv -p /usr/bin/python3.6 venv-mxnet
. venv-mxnet/bin/activate
#pip install opencv-python mxnet
#
#mkdir -p ${DIR_ROOT}/data/mlperf/imagenet-mxnet/val-jpeg
#tar -vxf ${DIR_ROOT}/data/ILSVRC2012_img_val.tar -C ${DIR_ROOT}/data/mlperf/imagenet-mxnet/val-jpeg
#
#pushd .
#cd ${DIR_ROOT}/data/mlperf/imagenet-mxnet/val-jpeg
#wget -qO- https://raw.githubusercontent.com/soumith/imagenetloader.torch/master/valprep.sh | bash
#
#mkdir -p ${DIR_ROOT}/data/mlperf/imagenet-mxnet/train-jpeg
#mkdir -p ${DIR_ROOT}/data/mlperf/imagenet-mxnet/train-tar
#
#popd
#
#tar -vxf ${DIR_ROOT}/data/ILSVRC2012_img_train.tar -C ${DIR_ROOT}/data/mlperf/imagenet-mxnet/train-tar
#for filename in ${DIR_ROOT}/data/mlperf/imagenet-mxnet/train-tar/*.tar; do
#        outputname="${DIR_ROOT}/data/mlperf/imagenet-mxnet/train-jpeg/$(basename "$filename" .tar)"
#        mkdir -p $outputname
#        tar -vxf $filename -C $outputname
#done

python ${DIR_ROOT}/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --list --recursive train ${DIR_ROOT}/data/mlperf/imagenet-mxnet/train-jpeg

python ${DIR_ROOT}/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --list --recursive val ${DIR_ROOT}/data/mlperf/imagenet-mxnet/val-jpeg

python ${DIR_ROOT}/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --pass-through --num-thread 20 train ${DIR_ROOT}/data/mlperf/imagenet-mxnet/train-jpeg

python ${DIR_ROOT}/venv-mxnet/lib/python3.6/site-packages/mxnet/tools/im2rec.py --pass-through --num-thread 20 val ${DIR_ROOT}/data/mlperf/imagenet-mxnet/val-jpeg


mv ${DIR_ROOT}/train.idx ${DIR_ROOT}/data/mlperf/imagenet-mxnet
mv ${DIR_ROOT}/train.rec ${DIR_ROOT}/data/mlperf/imagenet-mxnet
mv ${DIR_ROOT}/train.lst ${DIR_ROOT}/data/mlperf/imagenet-mxnet

mv ${DIR_ROOT}/val.idx ${DIR_ROOT}/data/mlperf/imagenet-mxnet
mv ${DIR_ROOT}/val.rec ${DIR_ROOT}/data/mlperf/imagenet-mxnet
mv ${DIR_ROOT}/val.lst ${DIR_ROOT}/data/mlperf/imagenet-mxnet

deactivate

popd

## -----------------------------------------
## ssd and maskrcnn
## -----------------------------------------
#./ssd/implementations/pytorch/download_dataset.sh
#
## -----------------------------------------
## maskrcnn
## -----------------------------------------
#./maskrcnn/implementations/download_weights.sh
#
## -----------------------------------------
## gnmt
## -----------------------------------------
#pushd .
#cd gnmt/implementations
#./download_dataset.sh "${DIR_ROOT}/data/mlperf/rnn_translator"
#popd
#
## -----------------------------------------
## transformer
## -----------------------------------------
#pushd .
#cd transformer/implementations/pytorch/data_preparation
#
#virtualenv -p /usr/bin/python3.6 venv-compile
#. venv-compile/bin/activate
#pip install torch==1.0.0 torchvision==0.2.2
#python setup.py install
#pip install mlperf_compliance==0.0.6
#
#./run_preprocessing.sh
#
#cp build/lib.linux-x86_64-3.6/fairseq/data/*.so fairseq/data/
#cp build/lib.linux-x86_64-3.6/fairseq/data/*.py fairseq/data/
#
#./run_conversion.sh
#deactivate
#rm -rf build
#rm fairseq/data/*.so
#
#popd
