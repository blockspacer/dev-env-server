FROM codercom/code-server

RUN sudo apt-get update; \
    sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common; \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -; \
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"; \
    sudo apt-get update && sudo apt-get install -y docker-ce-cli; \
    sudo rm -rf /var/lib/apt/lists/*

ENV DOCKER_HOST tcp://0.0.0.0:2375