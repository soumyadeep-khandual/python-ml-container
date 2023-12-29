FROM docker.io/nvidia/cuda:12.3.0-base-ubuntu22.04

# update system and install pip
RUN apt-get update && apt-get upgrade -y && apt-get install -y python3-pip && apt-get autoremove --purge && apt-get clean 

# install tensorflow-gpu
RUN pip install --no-cache-dir tensorflow[and-cuda]

# install torch
RUN pip install --no-cache-dir torch torchvision torchaudio

# set working dir
WORKDIR /workspace

# expose port for jupyer
EXPOSE 8888
