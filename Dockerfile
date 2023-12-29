FROM docker.io/nvidia/cuda:12.3.0-base-ubuntu22.04

# update system and install pip and update prompt
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y python3-pip \
    && apt-get autoremove --purge \
    && apt-get clean \
    && echo -e "\e[1;31m" >> /etc/bash.bashrc \
    && echo "    __  _____       ____               ______            __        _                 " >> /etc/bash.bashrc \
    && echo "   /  |/  / /      / __ \___ _   __   / ____/___  ____  / /_____ _(_)___  ___  _____ " >> /etc/bash.bashrc \
    && echo "  / /|_/ / /      / / / / _ \ | / /  / /   / __ \/ __ \/ __/ __ \`/ / __ \/ _ \/ ___/" >> /etc/bash.bashrc \
    && echo " / /  / / /___   / /_/ /  __/ |/ /  / /___/ /_/ / / / / /_/ /_/ / / / / /  __/ /     " >> /etc/bash.bashrc \
    && echo "/_/  /_/_____/  /_____/\___/|___/   \____/\____/_/ /_/\__/\__,_/_/_/ /_/\___/_/      " >> /etc/bash.bashrc \
    && echo "                                                                                     " >> /etc/bash.bashrc \
    && echo -e "\e[m" >> /etc/bash.bashrc \
    && echo 'export PS1="\[\e[31m\]ml-container\[\e[m\] \[\e[33m\]\w\[\e[m\] > "' >> /root/.bashrc
    
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
CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]
EXPOSE 8888

