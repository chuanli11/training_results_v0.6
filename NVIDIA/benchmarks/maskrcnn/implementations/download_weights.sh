#!/bin/bash

wget https://dl.fbaipublicfiles.com/detectron/ImageNetPretrained/MSRA/R-50.pkl
mkdir -p /home/$USER/data/mlperf/object_detection/coco2017/models
mv R-50.pkl /home/$USER/data/mlperf/object_detection/coco2017/models
