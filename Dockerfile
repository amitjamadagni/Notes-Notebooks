FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

# Add Julia dependencies
RUN apt-get install software-properties-common
RUN apt-get update
RUN add-apt-repository ppa:staticfloat/juliareleases
RUN add-apt-repository ppa:staticfloat/julia-deps
RUN apt-get update
RUN apt-get install -y julia libnettle4 && apt-get clean

USER main

# Install Julia kernel
RUN julia -e 'Pkg.add("IJulia")'
RUN julia -e 'Pkg.add("PyPlot")'
RUN julia -e 'Pkg.clone("https://github.com/JuliaQuantum/QuDynamics.jl.git")'
RUN julia -e 'Pkg.add("Gadfly")'
