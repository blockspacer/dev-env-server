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

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -; \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list; \
    sudo apt-get update; sudo apt-get install -y kubectl; \
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo curl -L https://github.com/wercker/stern/releases/download/1.10.0/stern_linux_amd64 -o /usr/local/bin/stern; \
    sudo chmod +x /usr/local/bin/stern

RUN sudo curl https://raw.githubusercontent.com/blendle/kns/master/bin/kns -o /usr/local/bin/kns; \ 
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf ; sudo ~/.fzf/install; \
    sudo chmod +x /usr/local/bin/kns

RUN sudo apt-get update; \
    sudo apt-get install -y zsh; sudo rm -rf /var/lib/apt/lists/*; \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
COPY .zshrc /home/coder/

ENV DOCKER_HOST tcp://0.0.0.0:2375
