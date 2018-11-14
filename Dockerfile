FROM continuumio/miniconda3:latest

COPY conda_requirements.yml .
RUN conda update -qy --file conda_requirements.yml \
    && rm conda_requirements.yml

RUN conda clean --yes --all

