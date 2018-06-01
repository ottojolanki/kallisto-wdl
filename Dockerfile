FROM ubuntu:16.04
RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/pachterlab/kallisto/releases/download/v0.44.0/kallisto_linux-v0.44.0.tar.gz && tar -xzf kallisto_linux-v0.44.0.tar.gz
ENV PATH="/kallisto_linux-v0.44.0:${PATH}"
