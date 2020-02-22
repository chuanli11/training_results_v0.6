#!/bin/bash

SYSTEM=${1:LambdaHyperplaneBasic}
NUM_RUN=${2:-2}
DIR_DATA=${3:${USER}}
DIR_LOG=${4:${USER}}

echo $DIR_DATA
echo $DIR_LOG

## -----------------------------------------
## ssd
## -----------------------------------------
#pushd .
#cd ssd/implementations/pytorch
#docker build --pull -t mlperf-nvidia:single_stage_detector .
#NEXP=$NUM_RUN DATADIR=${DIR_DATA}/mlperf/object_detection LOGDIR=${DIR_LOG}/single_stage_detector_$SYSTEM CONT=mlperf-nvidia:single_stage_detector PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
#popd
#
## -----------------------------------------
## maskrcnn
## -----------------------------------------
#pushd .
#cd maskrcnn/implementations/pytorch
#docker build --pull -t mlperf-nvidia:object_detection .
#NEXP=$NUM_RUN DATADIR=${DIR_DATA}/mlperf/object_detection LOGDIR=${DIR_LOG}/maskrcnn_$SYSTEM PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
#popd
#
## -----------------------------------------
## gnmt
## -----------------------------------------
#pushd .
#cd gnmt/implementations/pytorch
#docker build --pull -t mlperf-nvidia:rnn_translator .
#NEXP=$NUM_RUN DATADIR=${DIR_DATA}/mlperf/rnn_translator LOGDIR=${DIR_LOG}/gnmt_$SYSTEM PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
#popd
#
## -----------------------------------------
## transformer
## -----------------------------------------
#pushd .
#cd transformer/implementations/pytorch
#docker build --pull -t mlperf-nvidia:translation .
#NEXP=$NUM_RUN DATADIR=${DIR_DATA}/mlperf/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=${DIR_LOG}/translation_$SYSTEM PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
#popd
#
## -----------------------------------------
## resnet
## -----------------------------------------
#pushd .
#cd resnet/implementations/mxnet
#docker build --pull -t  mlperf-nvidia:image_classification .
#NEXP=$NUM_RUN DATADIR=${DIR_DATA}/mlperf/imagenet-mxnet LOGDIR=${DIR_LOG}/resnet_$SYSTEM DGXSYSTEM=$SYSTEM ./run.sub
#popd


# -----------------------------------------
# minigo
# -----------------------------------------
pushd .
cd minigo/implementations/tensorflow
#docker build --pull -t mlperf-nvidia:minigo .
NEXP=$NUM_RUN LOGDIR=${DIR_LOG}/minigo_$SYSTEM CONT=mlperf-nvidia:minigo PULL=0 DGXSYSTEM=$SYSTEM ./run.sub
popd
