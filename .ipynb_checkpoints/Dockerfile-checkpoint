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

COPY . /src
