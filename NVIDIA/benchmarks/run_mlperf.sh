#!/bin/bash

# -----------------------------------------
# resnet
# -----------------------------------------
pushd .
cd resnet/implementations/mxnet
docker build --pull -t  mlperf-nvidia:image_classification .
NEXP=2 DATADIR=/home/ubuntu/data/mlperf/imagenet-mxnet LOGDIR=/home/ubuntu/benchmarks/mlperf/resnet_DGX1 DGXSYSTEM=DGX1 ./run.sub
popd

# -----------------------------------------
# ssd
# -----------------------------------------
pushd .
cd ssd/implementations/pytorch
docker build --pull -t mlperf-nvidia:single_stage_detector .
NEXP=2 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/single_stage_detector_DGX1 CONT=mlperf-nvidia:single_stage_detector PULL=0 DGXSYSTEM=DGX1 ./run.sub
popd

# -----------------------------------------
# maskrcnn
# -----------------------------------------
pushd .
cd maskrcnn/implementations/pytorch
docker build --pull -t mlperf-nvidia:object_detection .
NEXP=2 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/maskrcnn_DGX1 PULL=0 DGXSYSTEM=DGX1 ./run.sub
popd

# -----------------------------------------
# gnmt
# -----------------------------------------
pushd .
cd gnmt/implementations/pytorch
docker build --pull -t mlperf-nvidia:rnn_translator .
NEXP=2 DATADIR=/home/ubuntu/data/mlperf/rnn_translator LOGDIR=/home/ubuntu/benchmarks/mlperf/gnmt_DGX1 PULL=0 DGXSYSTEM=DGX1 ./run.sub
popd

# -----------------------------------------
# transformer
# -----------------------------------------
pushd .
cd transformer/implementations/pytorch
docker build --pull -t mlperf-nvidia:translation .
NEXP=2 DATADIR=/home/ubuntu/data/mlperf/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=/home/ubuntu/benchmarks/mlperf/translation_DGX1 PULL=0 DGXSYSTEM=DGX1 ./run.sub
popd

# -----------------------------------------
# minigo
# -----------------------------------------
pushd .
cd minigo/implementations/tensorflow
docker build --pull -t mlperf-nvidia:minigo .
NEXP=2 LOGDIR=/home/ubuntu/benchmarks/mlperf/minigo_DGX1 CONT=mlperf-nvidia:minigo PULL=0 DGXSYSTEM=DGX1 ./run.sub
popd