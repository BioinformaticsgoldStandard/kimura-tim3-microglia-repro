FROM rocker/tidyverse:4.3.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libglpk-dev \
    libxml2-dev \
    libhdf5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c('Seurat', 'Matrix', 'dplyr', 'ggplot2', 'readxl', 'tibble', 'stringr', 'ggtext', 'cowplot', 'remotes'), repos='https://cloud.r-project.org/')"

RUN R -e "remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')"

WORKDIR /workspace

CMD ["/bin/bash"]
