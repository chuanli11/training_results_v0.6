# Object Detection (SSD)

### Prepare data

```
cd implementations/pytorch
./download_dataset.sh
```

### Build Docker Image

```
docker build --pull -t mlperf-nvidia:single_stage_detector .
```


### Run Benchmark

```
# Lambda Dual 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/single_stage_detector_LambdaDual2080Ti CONT=mlperf-nvidia:single_stage_detector PULL=0 DGXSYSTEM=LambdaDual2080Ti ./run.sub

# Lambda Quad 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/single_stage_detector_LambdaQuad2080Ti CONT=mlperf-nvidia:single_stage_detector PULL=0 DGXSYSTEM=LambdaQuad2080Ti ./run.sub

# Lambda Blade 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/single_stage_detector_LambdaBlade2080Ti CONT=mlperf-nvidia:single_stage_detector PULL=0 DGXSYSTEM=LambdaBlade2080Ti ./run.sub

# Lambda Hyperplane Basic
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/single_stage_detector_DGX1 CONT=mlperf-nvidia:single_stage_detector PULL=0 DGXSYSTEM=DGX1 ./run.sub
```
