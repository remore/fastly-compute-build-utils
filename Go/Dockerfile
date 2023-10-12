FROM golang:1.21
WORKDIR /app

RUN wget https://github.com/tinygo-org/tinygo/releases/download/v0.28.1/tinygo_0.28.1_amd64.deb
RUN dpkg -i tinygo_0.28.1_amd64.deb

RUN curl -LO "https://github.com/fastly/cli/releases/download/v10.4.0/fastly_10.4.0_linux_amd64.deb"
RUN apt install ./fastly_*_linux_amd64.deb

CMD ["go", "version"]
