#!/bin/bash

## DL params
OPTIMIZER="sgdwfastlars"
BATCHSIZE="208"
KVSTORE="horovod"
LR="5"  
WARMUP_EPOCHS="25"
EVAL_OFFSET="1" # Targeting epoch no 85
EVAL_PERIOD="4"
WD="0.0002"
LARSETA="0.001"
LABELSMOOTHING="0.1"
LRSCHED="pow2"
NUMEPOCHS="90"

NETWORK="resnet-v1b-fl"
export MXNET_CUDNN_SUPPLY_NORMCONV_CONSTANTS=1

DALI_PREFETCH_QUEUE="5"
DALI_NVJPEG_MEMPADDING="256"
DALI_CACHE_SIZE="0"
DALI_ROI_DECODE="1"  #needs to be set to 1 as default and proof perf uplift

## Environment variables for multi node runs
export HOROVOD_CYCLE_TIME=0.1
export HOROVOD_FUSION_THRESHOLD=67108864
export HOROVOD_NUM_STREAMS=2
export MXNET_HOROVOD_NUM_GROUPS=16
export NHWC_BATCHNORM_LAUNCH_MARGIN=64
export MXNET_EXEC_BULK_EXEC_MAX_NODE_TRAIN_FWD=999
export MXNET_EXEC_BULK_EXEC_MAX_NODE_TRAIN_BWD=25

## System run parms
DGXNNODES=2
DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME=08:00:00

## System config params
DGXNGPU=8
DGXSOCKETCORES=20
DGXHT=2 # HT is on is 2, HT off is 1
DGXIBDEVICES='--device=/dev/infiniband/rdma_cm --device=/dev/infiniband/ucm3 --device=/dev/infiniband/ucm2 --device=/dev/infiniband/ucm1 --device=/dev/infiniband/ucm0 --device=/dev/infiniband/uverbs3 --device=/dev/infiniband/uverbs2 --device=/dev/infiniband/uverbs1 --device=/dev/infiniband/uverbs0 --device=/dev/infiniband/issm3 --device=/dev/infiniband/umad3 --device=/dev/infiniband/issm2 --device=/dev/infiniband/umad2 --device=/dev/infiniband/issm1 --device=/dev/infiniband/umad1 --device=/dev/infiniband/issm0 --device=/dev/infiniband/umad0'
