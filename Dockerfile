ARG UBUNTU_VERSION=22.04

### Stage 1: Build ###
FROM ubuntu:$UBUNTU_VERSION AS build

ARG TARGETARCH
ARG GGML_CPU_ARM_ARCH=armv8-a

RUN apt-get update && \
    apt-get install -y build-essential git cmake libcurl4-openssl-dev

WORKDIR /app

# Copy your entire project (llama.cpp, models, and Dockerfile context)
COPY . .

# Build llama.cpp inside /app/llama.cpp
WORKDIR /app/llama.cpp

RUN if [ "$TARGETARCH" = "amd64" ]; then \
        cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DGGML_NATIVE=OFF -DLLAMA_BUILD_TESTS=OFF -DGGML_BACKEND_DL=ON -DGGML_CPU_ALL_VARIANTS=ON; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DGGML_NATIVE=OFF -DLLAMA_BUILD_TESTS=OFF -DGGML_CPU_ARM_ARCH=${GGML_CPU_ARM_ARCH}; \
    else \
        echo "Unsupported architecture"; exit 1; \
    fi && \
    cmake --build build -j $(nproc)

RUN mkdir -p /app/lib && \
    find build -name "*.so" -exec cp {} /app/lib \;

# Prepare final folder with binaries and Python scripts
RUN mkdir -p /app/full && \
    cp build/bin/* /app/full/ && \
    cp *.py /app/full/

### Stage 2: Base Image ###
FROM ubuntu:$UBUNTU_VERSION AS base

RUN apt-get update && \
    apt-get install -y libgomp1 curl && \
    apt-get autoremove -y && apt-get clean -y && \
    rm -rf /tmp/* /var/tmp/* && \
    find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete && \
    find /var/cache -type f -delete

COPY --from=build /app/lib/ /app

### Stage 3: Full Image with Python ###
FROM base AS full

COPY --from=build /app/full /app

WORKDIR /app

RUN apt-get update && \
    apt-get install -y git python3 python3-pip && \
    pip install --upgrade pip setuptools wheel && \
    # No requirements.txt, so skip pip install requirements \
    apt-get autoremove -y && apt-get clean -y && \
    rm -rf /tmp/* /var/tmp/* && \
    find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete && \
    find /var/cache -type f -delete

# Use non-root user for better security
RUN useradd -m appuser
USER appuser

ENTRYPOINT ["/app/tools.sh"]

### Stage 4: Light CLI Image ###
FROM base AS light

COPY --from=build /app/full/llama-cli /app/llama-cli

WORKDIR /app

RUN useradd -m appuser
USER appuser

# Entrypoint
CMD ["sleep", "infinity"]

### Stage 5: Server Image ###
FROM base AS server

ENV LLAMA_ARG_HOST=0.0.0.0

COPY --from=build /app/full/llama-server /app
COPY --from=build /app/full/llama-cli /app

WORKDIR /app

RUN useradd -m appuser
USER appuser

HEALTHCHECK CMD ["curl", "-f", "http://localhost:8080/health"]

ENTRYPOINT ["/app/llama-server"]
