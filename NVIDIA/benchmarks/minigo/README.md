# Lambda Notes

### Prepare Data

There is no data to be prepare


### Build Docker Image

```
docker build --pull -t mlperf-nvidia:minigo .
```

### Run benchmark

```
# Lambda Dual Basic
NEXP=3 LOGDIR=/home/ubuntu/benchmarks/mlperf/minigo_LambdaDualBasic CONT=mlperf-nvidia:minigo PULL=0 DGXSYSTEM=LambdaDualBasic ./run.sub

NEXP=3 LOGDIR=/home/ubuntu/benchmarks/mlperf/minigo_DGX1 CONT=mlperf-nvidia:minigo PULL=0 DGXSYSTEM=DGX1 ./run.sub
```

