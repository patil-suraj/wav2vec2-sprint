FROM ovhcom/ai-training-pytorch

RUN apt-get update && \
    apt install -y bash \
        build-essential \
        libsndfile1-dev

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install git-lfs && \
    git lfs install

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

COPY finetune.sh /workspace/wav2vec/
COPY run_common_voice.py /workspace/wav2vec/
COPY home-server.html /usr/bin/home-server.html

RUN chown -R 42420:42420 /workspace

ENTRYPOINT []
CMD ["supervisord", "-n", "-u", "42420", "-c", "/etc/supervisor/supervisor.conf"]
