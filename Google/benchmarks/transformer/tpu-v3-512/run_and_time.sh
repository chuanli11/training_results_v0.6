PYTHONPATH=.:/tmp/code_dir-transformer_code_1558539202/staging/models/rough/transformer/data_generators/:/tmp/code_dir-transformer_code_1558539202/staging/models/rough/:$PYTHONPATH python3 bin/t2t_trainer.py --cloud_tpu_name=TEST_TPU_1558539218.21 \
--data_dir=gs://mlperf-euw4/benchmark_data/transformer_new_sharded_train80_data \
--decode_from_file=gs://mlperf-euw4/benchmark_data/transformer_v2/wmt14-en-de.src \
--decode_hparams=batch_size=2048,beam_size=4,alpha=0.6,extra_length=50,mlperf_threshold=25.0 \
--decode_reference=gs://mlperf-euw4/benchmark_data/transformer_v2/wmt14-en-de.ref \
--decode_to_file=gs://mlsh_test/dev/assets/model_dir-transformer_model_dir_1558539202/decode.transformer_mlperf_tpu.translate_ende_wmt32k_packed.2x2_log_1018_2 \
--eval_steps=5 \
--hparams=learning_rate_constant=1.3,learning_rate_warmup_steps=550,optimizer_adam_beta1=0.86,optimizer_adam_beta2=0.92,pad_batch=true,batch_size=1024,mlperf_mode=true,max_length=80 \
--hparams_set=transformer_mlperf_tpu \
--iterations_per_loop=271 \
--keep_checkpoint_max=10 \
--local_eval_frequency=271 \
--model=transformer \
--output_dir=gs://mlsh_test/dev/assets/model_dir-transformer_model_dir_1558539202/train/ \
--problem=translate_ende_wmt32k_packed \
--schedule=train_and_decode \
--tpu_num_shards=512 \
--tpu_num_shards_per_host=8 \
--train_and_decode_with_low_level_api=True \
--train_steps=1897 \
--use_tpu=true
