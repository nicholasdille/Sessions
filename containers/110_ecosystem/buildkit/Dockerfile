FROM ubuntu:bionic

ENV \
    # Docker
    DOCKER_VERSION=18.03 \
    DIND_COMMIT=52379fa76dee07ca038624d639d9e14f4fb719ff \
    # Docker Compose
    DOCKER_COMPOSE_VERSION=1.23.1 \
    DOCKER_COMPOSE_SHA256=c176543737b8aea762022245f0f4d58781d3cb1b072bc14f3f8e5bb96f90f1a2 \
    # Docker Machine
    DOCKER_MACHINE_VERSION=0.15.0 \
    DOCKER_MACHINE_SHA256=44c5c62db13b6eb6a9d3e276c1181401c78327ff6303570936ba2cf5d137b7b5 \
    # Rancher CLI
    RANCHER_CLI_VERSION=0.5.1 \
    RANCHER_CLI_SHA256=2ed56421d89c817694b4cd8c12ac5aa18395fdf4095c4f6a40bf705ac6c80d6f \
    # Rancher Compose
    RANCHER_COMPOSE_VERSION=0.12.4 \
    RANCHER_COMPOSE_SHA256=6e8a85ca741e95ec2cc8f59b3faee9d0299a6878d64bd2a3b95fb87c0c391342

# Install APT packages
RUN apt-get update \
 # Necessary to orchestrate docker and go-agent
 && apt-get -y install \
        supervisor \
        sudo \
        iproute2 \
 # Required by Docker
 && apt-get -y install \
        ca-certificates \
        apt-transport-https \
        software-properties-common \
        curl \
        wget \
        openssl \
 # Required by DinD
 && apt-get -y install \
        btrfs-tools \
        e2fsprogs \
        iptables \
        xfsprogs \
        xz-utils \
 # Basic tools
 && apt-get -y install \
        gettext-base \
 # Setting locale for build environment
 && apt-get -y install language-pack-en \
 && update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX \
 && locale-gen \
 && mkdir -p /opt/bin

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
 && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
 && apt-get update \
 && apt-get -y install docker-ce=${DOCKER_VERSION}*

# Setup DinD (https://github.com/docker-library/docker/blob/master/1.12/dind/Dockerfile)
RUN set -x \
 && groupadd --system dockremap \
 && useradd --system -g dockremap dockremap \
 && echo 'dockremap:165536:65536' >> /etc/subuid \
 && echo 'dockremap:165536:65536' >> /etc/subgid \
 && wget "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind" -O /opt/bin/dind \
 && chmod +x /opt/bin/dind

# Install Docker Compose
RUN wget "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64" -O /usr/local/bin/docker-compose \
 && echo "${DOCKER_COMPOSE_SHA256} */usr/local/bin/docker-compose" | sha256sum -c - \
 && chmod +x /usr/local/bin/docker-compose

# Install Docker Machine
RUN wget "https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-Linux-x86_64" -O /usr/local/bin/docker-machine \
 && echo "${DOCKER_MACHINE_SHA256} */usr/local/bin/docker-machine" | sha256sum -c - \
 && chmod +x /usr/local/bin/docker-machine

# Install Rancher CLI
RUN wget "https://github.com/rancher/cli/releases/download/v${RANCHER_CLI_VERSION}/rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz" \
 && echo "${RANCHER_CLI_SHA256} *rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz" | sha256sum -c - \
 && tar -C /opt -xvzf rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz \
 && ln -s /opt/rancher-v${RANCHER_CLI_VERSION} /opt/rancher \
 && rm -rf rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz \
 && update-alternatives --install "/usr/bin/rancher" "rancher" "/opt/rancher/rancher" 1 \
 && update-alternatives --set "rancher" "/opt/rancher/rancher"

# Install Rancher Compose
RUN wget "https://github.com/rancher/rancher-compose/releases/download/v${RANCHER_COMPOSE_VERSION}/rancher-compose-linux-amd64-v${RANCHER_COMPOSE_VERSION}.tar.gz" \
 && echo "${RANCHER_COMPOSE_SHA256} *rancher-compose-linux-amd64-v${RANCHER_COMPOSE_VERSION}.tar.gz" | sha256sum -c - \
 && tar -C /opt -xvzf rancher-compose-linux-amd64-v${RANCHER_COMPOSE_VERSION}.tar.gz \
 && ln -s /opt/rancher-compose-v${RANCHER_COMPOSE_VERSION} /opt/rancher-compose \
 && rm -rf rancher-compose-linux-amd64-v${RANCHER_COMPOSE_VERSION}.tar.gz \
 && update-alternatives --install "/usr/bin/rancher-compose" "rancher-compose" "/opt/rancher-compose/rancher-compose" 1 \
 && update-alternatives --set "rancher-compose" "/opt/rancher-compose/rancher-compose"
