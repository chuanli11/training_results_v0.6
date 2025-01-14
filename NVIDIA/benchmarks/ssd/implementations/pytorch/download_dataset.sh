#!/usr/bin/env bash

# Copyright (c) 2018, Lambda Labs, Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Get COCO 2017 data sets
DIR_ROOT=${1:-"/home/${USER}"}
mkdir -p $DIR_ROOT/data/mlperf/object_detection/coco2017
cd $DIR_ROOT/data/mlperf/object_detection/coco2017
curl -O http://images.cocodataset.org/zips/train2017.zip
unzip train2017.zip
curl -O http://images.cocodataset.org/zips/val2017.zip
unzip val2017.zip
curl -O http://images.cocodataset.org/annotations/annotations_trainval2017.zip
unzip annotations_trainval2017.zip
cd $dir
