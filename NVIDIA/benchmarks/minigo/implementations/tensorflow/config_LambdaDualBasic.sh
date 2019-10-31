#!/bin/bash

## DL params
EXTRA_PARAMS=( )

## System run parms
DGXNNODES=1
DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME=6:00:00

## System config params
DGXNGPU=2
DGXSOCKETCORES=10
DGXNSOCKET=1
DGXHT=2         # HT is on is 2, HT off is 1
DGXIBDEVICES=''
