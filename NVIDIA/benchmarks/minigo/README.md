# Lambda Notes

### Prepare Data

There is no data to be prepare


### Build Docker Image

```
docker build --pull -t mlperf-nvidia:minigo .
```

### Run benchmark

```
# Lambda Dual 2080Ti
NEXP=3 LOGDIR=/home/ubuntu/benchmarks/mlperf/minigo_LambdaDual2080Ti CONT=mlperf-nvidia:minigo PULL=0 DGXSYSTEM=LambdaDual2080Ti ./run.sub

# Lambda Quad 2080Ti
NEXP=2 LOGDIR=/home/ubuntu/benchmarks/mlperf/minigo_LambdaQuad2080Ti CONT=mlperf-nvidia:minigo PULL=0 DGXSYSTEM=LambdaQuad2080Ti ./run.sub

# Lambda Blade 2080Ti
NEXP=2 LOGDIR=/home/ubuntu/benchmarks/mlperf/minigo_LambdaBlade2080Ti CONT=mlperf-nvidia:minigo PULL=0 DGXSYSTEM=LambdaBlade2080Ti ./run.sub

# Lambda HyperPlane Basic
NEXP=3 LOGDIR=/home/ubuntu/benchmarks/mlperf/minigo_LambdaHyperplaneBasic CONT=mlperf-nvidia:minigo PULL=0 DGXSYSTEM=LambdaHyperplaneBasic ./run.sub
```

