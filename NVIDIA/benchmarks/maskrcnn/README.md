# Object Detection (MaskRCNN)

### Prepare data

```
# The data is the same as the ssd benchmark.


# Download pre-trained backbone model.
cd makercnn/implementations
./download_weights.sh
```

### Build Docker Image

```
cd pytorch
docker build --pull -t mlperf-nvidia:object_detection .
```


### Run Benchmark

```
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/maskrcnn_LambdaDualBasic PULL=0 DGXSYSTEM=LambdaDualBasic ./run.sub

NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/maskrcnn_DGX1 PULL=0 DGXSYSTEM=DGX1 ./run.sub
```
