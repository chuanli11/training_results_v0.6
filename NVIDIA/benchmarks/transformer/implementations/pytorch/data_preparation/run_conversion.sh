#!/bin/bash

set -e

DIR_ROOT="/home/${USER}"

SEED=$1

python3 convert_utf8_to_fairseq_binary.py --data_dir $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de
