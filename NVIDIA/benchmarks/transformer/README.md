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
# Lambda Dual 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=/home/ubuntu/benchmarks/mlperf/translation_LambdaDual2080Ti PULL=0 DGXSYSTEM=LambdaDual2080Ti ./run.sub

# Lambda Quad 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=/home/ubuntu/benchmarks/mlperf/translation_LambdaQuad2080Ti PULL=0 DGXSYSTEM=LambdaQuad2080Ti ./run.sub

# Lambda Blade 2080Ti
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=/home/ubuntu/benchmarks/mlperf/translation_LambdaBlade2080Ti PULL=0 DGXSYSTEM=LambdaBlade2080Ti ./run.sub

# Lambda Hyperplane Basic
NEXP=3 DATADIR=/home/ubuntu/data/mlperf/translation/examples/translation/wmt14_en_de/utf8 LOGDIR=/home/ubuntu/benchmarks/mlperf/translation_LambdaHyperplaneBasic PULL=0 DGXSYSTEM=LambdaHyperplaneBasic ./run.sub
```


### Notes

The download data part in the original `mlperf/training_results_v0.6` is broken (or supposedly to be run in side of a docker). Need a seperate sub-folder for doing it. 
