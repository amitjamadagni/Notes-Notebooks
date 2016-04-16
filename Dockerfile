FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

# Add Julia dependencies
RUN apt-get update
RUN apt-get install -y julia libnettle4 && apt-get clean

USER main

# Install Julia kernel
RUN julia -e 'Pkg.add("IJulia")'
RUN julia -e 'Pkg.add("Gadfly")'
RUN julia -e 'Pkg.clone("https://github.com/JuliaQuantum/QuBase.jl.git")'
RUN julia -e 'Pkg.clone("https://github.com/acroy/Expokit.jl.git")'
RUN julia -e 'Pkg.clone("https://github.com/marcusps/ExpmV.jl.git")'
RUN julia -e 'Pkg.clone("https://github.com/JuliaQuantum/QuDynamics.jl.git")'
