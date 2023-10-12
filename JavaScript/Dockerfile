FROM node:latest
WORKDIR /app

RUN curl -LO "https://github.com/fastly/cli/releases/download/v10.4.0/fastly_10.4.0_linux_amd64.deb"
RUN apt install ./fastly_*_linux_amd64.deb

CMD ["fastly", "version"]
