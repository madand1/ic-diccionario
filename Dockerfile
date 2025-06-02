FROM debian:latest

RUN apt-get update && \
    apt-get install -y aspell aspell-es && \
    rm -rf /var/lib/apt/lists/*

CMD ["bash"]
