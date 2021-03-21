FROM ovhcom/ai-training-pytorch

RUN apt-get update && \
    apt install -y bash \
        build-essential \
        libsndfile1-dev

RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir \
    datasets \
    jiwer==2.2.0 \
    soundfile \
    torchaudio \
    lang-trans==0.6.0 \
    librosa==0.8.0

RUN pip install git+https://github.com/huggingface/transformers.git

RUN mkdir -p /workspace/wav2vec/

COPY finetune.sh run_common_voice.py  finetune_with_params.sh /workspace/wav2vec/

COPY home-server.html /usr/bin/home-server.html

RUN chown -R 42420:42420 /workspace

#Default training env variables
ENV model_name_or_path="facebook/wav2vec2-large-xlsr-53" \
    dataset_config_name="fr" \
    output_dir="/workspace/output_models/wav2vec2-large-xlsr-french-demo" \
    cache_dir="/workspace/data" \
    num_train_epochs="1" \
    per_device_train_batch_size="32" \
    evaluation_strategy="steps" \
    learning_rate="3e-4" \
    warmup_steps="500" \
    save_steps="10" \
    eval_steps="10" \
    save_total_limit="1" \
    logging_steps="10" \
    feat_proj_dropout="0.0" \
    layerdrop="0.1" \
    max_train_samples=100 \
    max_val_samples=100

WORKDIR /workspace
ENTRYPOINT []
CMD ["supervisord", "-n", "-u", "42420", "-c", "/etc/supervisor/supervisor.conf"]
