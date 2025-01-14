#!/bin/bash

## DL params
MAX_TOKENS=2560
LEARNING_RATE="0.500e-3"
WARMUP_UPDATES=1000
EXTRA_PARAMS="--max-source-positions 64 --max-target-positions 64 --enable-parallel-backward-allred-opt --parallel-backward-allred-opt-threshold 105404416 --parallel-backward-allred-cuda-nstreams 2 --adam-betas (0.9,0.98) "

## System run parms
DGXNNODES=1
DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME=02:00:00

## System config params
DGXNGPU=2
DGXSOCKETCORES=10
DGXNSOCKET=1
DGXHT=2         # HT is on is 2, HT off is 1
DGXIBDEVICES=''
