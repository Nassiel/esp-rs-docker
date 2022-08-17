# ESP-RS: Docker building image
Docker image to build using ESP toolchain. You can find the docker entry [here](https://hub.docker.com/repository/docker/nassiel/esp-rs-docker).

## Usage

Create a Dockerfile with the next structure inside your rust esp-idf project:

```docker
FROM nassiel/esp-rs-docker:latest

WORKDIR /home/builder/app
COPY --chown=builder:builder . .

RUN cargo build --release
```

Then, build it to generate the package to deploy:

```bash
docker build -t my-rust-esp-project .
```

Then, use it to build deploy it in your device

```bash
docker run -it --device /dev/ttyUSB0 --rm cargo espflash --release
```
