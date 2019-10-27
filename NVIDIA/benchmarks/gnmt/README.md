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
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/rnn_translator LOGDIR=/home/ubuntu/benchmarks/mlperf/gmnt PULL=0 DGXSYSTEM=LambdaDualBasic ./run.sub
```