FROM continuumio/miniconda3:latest

COPY conda_requirements.yml .
RUN conda env update -n base -q --file conda_requirements.yml \
    && rm conda_requirements.yml

RUN conda clean --yes --all

