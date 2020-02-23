#!/bin/bash

SYSTEM=${1:-"2xLambdaHyperplaneBasic"}
NUM_RUN=${2:-2}
DIR_DATA=${3:-"/home/${USER}/data"}
DIR_LOG=${4:-"/home/${USER}/benchmark/mlperf/"}

echo $SYSTEM
echo $NUM_RUN
echo $DIR_DATA
echo $DIR_LOG

# -----------------------------------------
# ssd
# -----------------------------------------
pushd .
cd ssd/implementations/pytorch
source config_${SYSTEM}.sh && CONT="mlperf-nvidia:single_stage_detector" DATADIR=${DIR_DATA}/object_detection LOGDIR=${DIR_LOG}/single_stage_detector_${SYSTEM} DGXSYSTEM=${SYSTEM} NEXP=$NUM_RUN srun -N $DGXNNODES -t $WALLTIME --ntasks-per-node $DGXNGPU run.sub
popd

# -----------------------------------------
# maskrcnn
# -----------------------------------------
pushd .
cd maskrcnn/implementations/pytorch
source config_${SYSTEM}.sh && CONT="mlperf-nvidia:object_detection" DATADIR=${DIR_DATA}/object_detection LOGDIR=${DIR_LOG}/maskrcnn_${SYSTEM} DGXSYSTEM=${SYSTEM} NEXP=$NUM_RUN srun -N $DGXNNODES -t $WALLTIME run.sub

popd

# -----------------------------------------
# gnmt
# -----------------------------------------
pushd .
cd gnmt/implementations/pytorch
source config_${SYSTEM}.sh && CONT="mlperf-nvidia:rnn_translator" DATADIR=${DIR_DATA}/rnn_translator LOGDIR=${DIR_LOG}/gnmt_${SYSTEM} DGXSYSTEM=${SYSTEM} NEXP=$NUM_RUN srun -N $DGXNNODES -t $WALLTIME run.sub
popd

# -----------------------------------------
# transformer
# -----------------------------------------
pushd .
cd transformer/implementations/pytorch
source config_${SYSTEM}.sh && CONT="mlperf-nvidia:translation" DATADIR=${DIR_DATA}/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=${DIR_LOG}/translation_${SYSTEM} DGXSYSTEM=${SYSTEM} NEXP=$NUM_RUN srun -N $DGXNNODES -t $WALLTIME run.sub
popd

# -----------------------------------------
# resnet
# -----------------------------------------
pushd .
cd resnet/implementations/mxnet
source config_${SYSTEM}.sh && CONT="mlperf-nvidia:image_classification" DATADIR=${DIR_DATA}/imagenet-mxnet LOGDIR=${DIR_LOG}/resnet_${SYSTEM} DGXSYSTEM=${SYSTEM} NEXP=$NUM_RUN srun -N $DGXNNODES -t $WALLTIME run.sub
popd


## -----------------------------------------
## minigo
## -----------------------------------------
#pushd .
#cd minigo/implementations/tensorflow
#source config_${SYSTEM}.sh && CONT="mlperf-nvidia:minigo" LOGDIR=${DIR_DATA}/minigo_${SYSTEM} DGXSYSTEM=$SYSTEM NEXP=$NUM_RUN srun -N $DGXNNODES -t $WALLTIME run.sub
#popd
