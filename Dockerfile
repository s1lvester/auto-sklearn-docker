FROM jupyter/scipy-notebook:python-3.9

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN apt-get update && apt-get full-upgrade -y && \
    # apt-get install --no-install-recommends -y && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

RUN mamba update -y -n base --all && \
    mamba install -y \
    cython \
    gxx_linux-64 \
    gcc_linux-64 \
    swig \
    plotly \
    pandas-profiling \
    jupyterlab-git && \
    mamba install -y -c conda-forge \
    theme-material-darcula \
    jupyterlab_vim && \
    mamba clean --all -f -y


RUN pip3 install --no-cache-dir \
    configspace==0.4.21 \
    auto-sklearn==0.15.0

WORKDIR "${HOME}"
