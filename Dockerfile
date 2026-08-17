# Base Rocker con R 4.3.1
FROM rocker/tidyverse:4.3.1

# Installazione librerie di sistema, Python e JupyterHub per Pyterhub
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglpk-dev \
    libxml2-dev \
    libhdf5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    git \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Installazione JupyterLab e JupyterHub per compatibilita con Dora
RUN pip3 install --no-cache-dir --break-system-packages jupyterlab jupyterhub notebook

# Installazione pacchetti R per Paper 2
RUN R -e "install.packages(c('Seurat', 'Matrix', 'dplyr', 'ggplot2', 'readxl', 'tibble', 'stringr', 'ggtext', 'cowplot', 'remotes', 'IRkernel'), repos='https://cloud.r-project.org/')"

# Registrazione del kernel R per Jupyter
RUN R -e "IRkernel::installspec(user = FALSE)"

# Installazione DoubletFinder
RUN R -e "remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')"

WORKDIR /workspace

CMD ["jupyterhub-singleuser"]
