FROM debian:stable-20171210

RUN apt-get update && apt-get install -y build-essential zlib1g-dev libssl-dev libmemcached-dev && rm -rf /var/lib/apt/lists

ENV miniconda_path=/miniconda3
ENV miniconda_repo=https://repo.continuum.io/miniconda
ENV miniconda_version=4.3.31
ENV miniconda_filename=Miniconda3-${miniconda_version}-Linux-x86_64.sh

RUN wget ${miniconda_repo}/${miniconda_filename} && bash ${miniconda_filename} -b -p ${miniconda_path} && rm ${miniconda_filename}
ENV PATH=${miniconda_path}/bin:${PATH}
RUN conda update -y --all

COPY conda_requirements.yml .
RUN conda env update -n base --file conda_requirements.yml && rm conda_requirements.yml

RUN LDFLAGS=-fno-lto CPATH=${miniconda_path}/include LIBRARY_PATH=${miniconda_path}/lib pip install uwsgi
