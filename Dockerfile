FROM jertubiana/scannet:latest
# Compile HHsuite from source.
SHELL ["/bin/bash", "-c"]

RUN apt update && apt install -y \
    git \
    build-essential \
    libssl-dev \ 
    cmake

RUN git clone --branch v3.3.0 https://github.com/soedinglab/hh-suite.git /tmp/hh-suite \
    && mkdir /tmp/hh-suite/build \
    && pushd /tmp/hh-suite/build \
    && cmake -DCMAKE_INSTALL_PREFIX=/opt/hhsuite .. \
    && make -j 4 && make install \
    && ln -s /opt/hhsuite/bin/* /usr/bin \
    && popd \
    && rm -rf /tmp/hh-suite

COPY paths_patch.py utilities/paths.py
COPY predict_bindingsites_patch.py predict_bindingsites.py
COPY run.py run.py
COPY 1utn.pdb 1utn.pdb 
COPY molstar.html molstar.html