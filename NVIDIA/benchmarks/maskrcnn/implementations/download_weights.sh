#!/bin/bash

DIR_ROOT=${1:-"/home/${USER}"}

wget https://dl.fbaipublicfiles.com/detectron/ImageNetPretrained/MSRA/R-50.pkl
mkdir -p $DIR_ROOT/data/mlperf/object_detection/coco2017/models
mv R-50.pkl $DIR_ROOT/data/mlperf/object_detection/coco2017/models
