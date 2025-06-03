FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04
WORKDIR /app
RUN apt update && apt upgrade -y
RUN apt install -y wget git python3 python3-venv libgl1 libglib2.0-0 apt-transport-https libgoogle-perftools-dev bc python3-pip

# Install Miniconda into /app/vendor/miniconda
ENV CONDA_DIR=/app/vendor/miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
    rm /tmp/miniconda.sh && \
    $CONDA_DIR/bin/conda clean -afy

RUN apt install -y curl


ENV PATH=$CONDA_DIR/bin:$PATH



COPY app/run.sh /app/run.sh
RUN chmod +x /app/run.sh


ENTRYPOINT ["/app/run.sh"]