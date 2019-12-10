#!/bin/bash

SYSTEM=${1:LambdaHyperplaneBasic}
NUM_RUN=${2:-2}

# -----------------------------------------
# ssd
# -----------------------------------------
pushd .
cd ssd/implementations/pytorch
docker build --pull -t mlperf-nvidia:single_stage_detector .
NEXP=$NUM_RUN DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/single_stage_detector_$SYSTEM CONT=mlperf-nvidia:single_stage_detector PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
popd

# -----------------------------------------
# maskrcnn
# -----------------------------------------
pushd .
cd maskrcnn/implementations/pytorch
docker build --pull -t mlperf-nvidia:object_detection .
NEXP=$NUM_RUN DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/maskrcnn_$SYSTEM PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
popd

# -----------------------------------------
# gnmt
# -----------------------------------------
pushd .
cd gnmt/implementations/pytorch
docker build --pull -t mlperf-nvidia:rnn_translator .
NEXP=$NUM_RUN DATADIR=/home/ubuntu/data/mlperf/rnn_translator LOGDIR=/home/ubuntu/benchmarks/mlperf/gnmt_$SYSTEM PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
popd

# -----------------------------------------
# transformer
# -----------------------------------------
pushd .
cd transformer/implementations/pytorch
docker build --pull -t mlperf-nvidia:translation .
NEXP=$NUM_RUN DATADIR=/home/ubuntu/data/mlperf/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=/home/ubuntu/benchmarks/mlperf/translation_$SYSTEM PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
popd

# -----------------------------------------
# resnet
# -----------------------------------------
pushd .
cd resnet/implementations/mxnet
docker build --pull -t  mlperf-nvidia:image_classification .
NEXP=$NUM_RUN DATADIR=/home/ubuntu/data/mlperf/imagenet-mxnet LOGDIR=/home/ubuntu/benchmarks/mlperf/resnet_$SYSTEM DGXSYSTEM=$SYSTEM ./run.sub
popd


# -----------------------------------------
# minigo
# -----------------------------------------
pushd .
cd minigo/implementations/tensorflow
docker build --pull -t mlperf-nvidia:minigo .
NEXP=$NUM_RUN LOGDIR=/home/ubuntu/benchmarks/mlperf/minigo_$SYSTEM CONT=mlperf-nvidia:minigo PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
popd
