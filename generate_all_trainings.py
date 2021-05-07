#!/usr/bin/env python
# coding: utf-8

import os
import csv

with open('wav2vec_languages.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    # This skips the first row of the CSV file because it's a header
    next(csv_reader)
    for (language_code, language_full_name) in csv_reader:
        print(f"#Launching Training for {language_code}-{language_full_name}")
        cmd = f"ovhai job run --gpu 1 --name '{language_code}-{language_full_name}' --volume cache@GRA:/workspace/.cache:RW:cache --volume data@GRA/{language_code}:/workspace/data/{language_code}:RW:cache --volume output_models@GRA/{language_code}:/workspace/output_models/{language_code}:RW:cache -e model_name_or_path='facebook/wav2vec2-large-xlsr-53' -e dataset_config_name={language_code} -e output_dir='/workspace/output_models/{language_code}/wav2vec2-large-xlsr-{language_code}-{language_full_name}-demo' -e cache_dir='/workspace/data/{language_code}/data' -e num_train_epochs=10 databuzzword/hf-wav2vec -- sh /workspace/wav2vec/finetune_with_params.sh"
        print(cmd)

## uncomment here to run all jobs directly
#        stream = os.popen(cmd)
#        output = stream.read()
#        output




