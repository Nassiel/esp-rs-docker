FROM rust:slim-bullseye

RUN apt update; apt install -y git \
    curl \
    gcc \
    clang \
    ninja-build \
    cmake \
    libudev-dev \
    unzip \
    xz-utils \
    python3 \
    python3-pip \
    python3-venv \
    libusb-1.0-0 \
    libssl-dev \
    pkg-config \
    libtinfo5 \
    libpython2.7

RUN useradd builder
USER builder
WORKDIR /home/builder

COPY --chown=builder:builder install-rust-toolchain.sh .
RUN chmod +x install-rust-toolchain.sh
RUN ./install-rust-toolchain.sh
RUN echo "export LIBCLANG_PATH=\"/home/builder/.espressif/tools/xtensa-esp32-elf-clang/esp-14.0.0-20220415-x86_64-unknown-linux-gnu/lib/\"" >> .bashrc
RUN echo "export PATH=\"/home/builder/.espressif/tools/xtensa-esp32-elf-gcc/8_4_0-esp-2021r2-patch3-x86_64-unknown-linux-gnu/bin/:/home/builder/.espressif/tools/xtensa-esp32s2-elf-gcc/8_4_0-esp-2021r2-patch3-x86_64-unknown-linux-gnu/bin/:/home/builder/.espressif/tools/xtensa-esp32s3-elf-gcc/8_4_0-esp-2021r2-patch3-x86_64-unknown-linux-gnu/bin/:/home/builder/.local/bin:$PATH\"" >> .bashrc
RUN rustup default esp
RUN rm install-rust-toolchain.sh

CMD ["/bin/bash"]
