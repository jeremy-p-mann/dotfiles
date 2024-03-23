FROM ubuntu:jammy


ARG DEBIAN_FRONTEND=noninteractive 
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y python3-pip python3-dev && \
    apt-get install -y software-properties-common && \
    apt-get install -y ansible && \
    apt-get install -y git && \
    add-apt-repository ppa:neovim-ppa/unstable && \
    apt-get install -y neovim && \
    apt-get install -y python3-neovim && \
    apt-get install -y fd-find && \
    git clone https://github.com/jmann277/dotfiles --depth=1 && \
    ansible-playbook /dotfiles/configuration/install_packages.yml && \
    ansible-playbook /dotfiles/configuration/jeremy.yml -t user && \
    ansible-playbook /dotfiles/configuration/programming_languages.yml && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER jeremypmann

RUN ansible-playbook /dotfiles/configuration/jeremy.yml -t directory_structure  && \
    mkdir -p /home/jeremypmann/.local/bin && \
    ln -s $(which fdfind) ~/.local/bin/fd && \
    ansible-playbook /dotfiles/configuration/install_dotfiles.yml && \
    ansible-playbook /dotfiles/configuration/zsh_plugins.yml && \
    curl https://sh.rustup.rs -sSf | bash -s -- -y && \
    ansible-playbook /dotfiles/configuration/language_servers.yml -t python && \
    ansible-playbook /dotfiles/configuration/python_dev.yml && \
    ansible-playbook /dotfiles/configuration/python_data_science.yml && \
    nvim --headless "+Lazy! sync" +qa && \
    nvim --headless "+30sleep" +qa

WORKDIR /home/jeremypmann

ENTRYPOINT ["/bin/zsh", "--login"]
