FROM andrewosh/binder-base

USER root

RUN apt-get update \
    && apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o DPkg::Options::="--force-confold" \
    && apt-get install -y \
    man-db \
    libc6 \
    libc6-dev \
    build-essential \
    wget \
    curl \
    file \
    vim \
    screen \
    tmux \
    unzip \
    pkg-config \
    cmake \
    gfortran \
    gettext \
    libreadline-dev \
    libncurses-dev \
    libpcre3-dev \
    # libgnutls28 \
    libzmq3-dev \
    libzmq3 \
    libnettle4 \
    python \
    python-yaml \
    python-m2crypto \
    python-crypto \
    msgpack-python \
    python-dev \
    python-setuptools \
    supervisor \
    python-jinja2 \
    python-requests \
    python-isodate \
    python-git \
    python-pip \
    && apt-get clean

# RUN pip install --upgrade pyzmq PyDrive google-api-python-client jsonpointer jsonschema tornado sphinx pygments nose readline mistune invoke numpy scipy cython matplotlib qutip
RUN pip install --upgrade pyzmq PyDrive google-api-python-client jsonpointer tornado nose readline mistune invoke numpy scipy cython matplotlib qutip

# RUN git clone --recursive --branch 3.x https://github.com/ipython/ipython.git; cd ipython; python setup.py install; cd ..; rm -rf ipython

RUN mkdir -p /opt/julia_0.4.5 && \
    curl -s -L https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4.5-linux-x86_64.tar.gz | tar -C /opt/julia_0.4.5 -x -z

RUN ln -fs /opt/julia_0.4.5 /opt/julia

RUN echo "PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/julia/bin\"" > /etc/environment && \
    echo "export PATH" >> /etc/environment && \
    echo "source /etc/environment" >> /root/.bashrc

RUN /opt/julia/bin/julia -e 'Pkg.add("IJulia")'
RUN /opt/julia/bin/julia -e 'Pkg.build("IJulia")'
RUN /opt/julia/bin/julia -e 'Pkg.add("PyPlot")'
RUN /opt/julia/bin/julia -e 'Pkg.build("PyPlot")'
RUN /opt/julia/bin/julia -e 'Pkg.clone("https://github.com/JuliaQuantum/QuDynamics.jl.git")'

ENTRYPOINT /bin/bash
