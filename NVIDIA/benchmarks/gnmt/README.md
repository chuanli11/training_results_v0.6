# Translation (Google Neural Machine Translation)

### Prepare Data

```
./download_dataset.sh /home/ubuntu/data/mlperf/rnn_translator
```

### Build Docker Image

```
cd pytorch
docker build --pull -t mlperf-nvidia:rnn_translator . 
```

### Run Benchmark

```
# Lambda Dual 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/rnn_translator LOGDIR=/home/ubuntu/benchmarks/mlperf/gnmt_LambdaDual2080Ti PULL=0 DGXSYSTEM=LambdaDual2080Ti ./run.sub

# Lambda Quad 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/rnn_translator LOGDIR=/home/ubuntu/benchmarks/mlperf/gnmt_LambdaQuad2080Ti PULL=0 DGXSYSTEM=LambdaQuad2080Ti ./run.sub

# Lambda Blade 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/rnn_translator LOGDIR=/home/ubuntu/benchmarks/mlperf/gnmt_LambdaBlade2080Ti PULL=0 DGXSYSTEM=LambdaBlade2080Ti ./run.sub

# Lambda Hyperplane Basic
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/rnn_translator LOGDIR=/home/ubuntu/benchmarks/mlperf/gnmt_DGX1 PULL=0 DGXSYSTEM=DGX1 ./run.sub
```
