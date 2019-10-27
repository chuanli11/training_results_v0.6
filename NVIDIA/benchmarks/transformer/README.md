# Translation (Transformer)

### Prepare Dataset

```
cd implementations/pytorch/data_preparation

virtualenv -p /usr/bin/python3.6 venv-compile
. venv-compile/bin/activate
pip install torch==1.0.0 torchvision==0.2.2
python setup.py install
pip install mlperf_compliance==0.0.6

./run_preprocessing.sh

cp build/lib.linux-x86_64-3.6/fairseq/data/*.so fairseq/data/
cp build/lib.linux-x86_64-3.6/fairseq/data/*.py fairseq/data/

./run_conversion.sh
deactivate
rm -rf build
rm fairseq/data/*.so
```

### Build Docker Image

```
cd implementations/pytorch
docker build --pull -t mlperf-nvidia:translation .
```

### Run Benchmark

```
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=/home/ubuntu/benchmarks/mlperf/translation_LambdaDualBasic PULL=0 DGXSYSTEM=LambdaDualBasic ./run.sub

NEXP=3 DATADIR=/home/ubuntu/data/mlperf/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=/home/ubuntu/benchmarks/mlperf/translation_DGX1 PULL=0 DGXSYSTEM=DGX1 ./run.sub
```


### Notes

The download data part in the original `mlperf/training_results_v0.6` is broken (or supposedly to be run in side of a docker). Need a seperate sub-folder for doing it. 
