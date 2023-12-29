FROM docker.io/nvidia/cuda:12.3.0-base-ubuntu22.04

# update system and install pip and update prompt
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y python3-pip \
    && apt-get autoremove --purge \
    && apt-get clean \
    && echo "PS1='\[\e[96;1m\]ml-container \[\e[90m\]\w \[\e[96m\]> \[\e[0m\]'" >> /root/.bashrc
    
# install tensorflow-gpu
RUN pip install --no-cache-dir tensorflow[and-cuda]

# install torch
RUN pip install --no-cache-dir torch torchvision torchaudio

# install additional python packages
RUN pip install --no-cache-dir \
    lightgbm xgboost \
    transformers nltk spacy \
    jupyter ipywidgets \
    pyarrow opencv-python-headless Pillow \
    torchmetrics lightning \
    scipy seaborn matplotlib scikit-learn pandas numpy

# set working dir
WORKDIR /workspace

# expose port for jupyer
CMD ["bash", "-c", "jupyter notebook --notebook-dir=/workspace --ip 0.0.0.0 --no-browser --allow-root"]
EXPOSE 8888

