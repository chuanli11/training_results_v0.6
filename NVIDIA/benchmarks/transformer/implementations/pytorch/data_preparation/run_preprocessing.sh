#!/bin/bash

set -e

SEED=$1

DIR_ROOT=${1:-1"/home/${USER}"}


# TODO: Add SEED to process_data.py since this uses a random generator (future PR)
#export PYTHONPATH=/research/transformer/transformer:${PYTHONPATH}
# Add compliance to PYTHONPATH
# export PYTHONPATH=/mlperf/training/compliance:${PYTHONPATH}

mkdir -p $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de
mkdir -p $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de/utf8

cp reference_dictionary.ende.txt $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de/dict.en.txt
cp reference_dictionary.ende.txt $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de/dict.de.txt

sed -i "1s/^/\'<lua_index_compat>\'\n/" $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de/dict.en.txt
sed -i "1s/^/\'<lua_index_compat>\'\n/" $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de/dict.de.txt

# TODO: make code consistent to not look in two places (allows temporary hack above for preprocessing-vs-training)
cp reference_dictionary.ende.txt $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de/utf8/dict.en.txt
cp reference_dictionary.ende.txt $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de/utf8/dict.de.txt

wget https://storage.googleapis.com/tf-perf-public/official_transformer/test_data/newstest2014.tgz
tar xfzv newstest2014.tgz

mv newstest2014.en $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de/newstest2014.en
mv newstest2014.de $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de/newstest2014.de
rm newstest2014.tgz

python3 preprocess.py --raw_dir $DIR_ROOT/data/mlperf/translation/raw_data/ --data_dir $DIR_ROOT/data/mlperf/translation/examples/translation/wmt14_en_de

