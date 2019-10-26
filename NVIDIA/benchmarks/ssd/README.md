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
DATADIR=/home/ubuntu/data/mlperf/object_detection LOGDIR=/home/ubuntu/benchmarks/mlperf/single_stage_detector CONT=mlperf-nvidia:single_stage_detector PULL=0 DGXSYSTEM=LambdaDualBasic ./run.sub
```
