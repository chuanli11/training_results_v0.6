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
# Lambda Dual 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/maskrcnn_LambdaDual2080Ti PULL=0 DGXSYSTEM=LambdaDual2080Ti ./run.sub

# Lambda Quad 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/maskrcnn_LambdaQuad2080Ti PULL=0 DGXSYSTEM=LambdaQuad2080Ti ./run.sub

# Lambda Blade 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/maskrcnn_LambdaBlade2080Ti PULL=0 DGXSYSTEM=LambdaBlade2080Ti ./run.sub

# Lambda Hyperplane Basic
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/maskrcnn_LambdaHyperplaneBasic PULL=0 DGXSYSTEM=LambdaHyperplaneBasic ./run.sub
```
