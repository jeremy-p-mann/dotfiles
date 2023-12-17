FROM ubuntu:jammy


ARG DEBIAN_FRONTEND=noninteractive 
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y python3-pip python3-dev && \
    apt-get install -y software-properties-common && \
    apt-get install -y ansible && \
    apt-get install -y git


RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install -y neovim
RUN apt-get install -y python3-neovim
RUN apt-get install -y fd-find

RUN git clone https://github.com/jmann277/dotfiles --depth=1
RUN ansible-playbook /dotfiles/configuration/install_packages.yml
RUN ansible-playbook /dotfiles/configuration/jeremy.yml

USER jeremypmann

RUN mkdir -p /home/jeremypmann/.local/bin
RUN ln -s $(which fdfind) ~/.local/bin/fd

RUN ansible-playbook /dotfiles/configuration/install_dotfiles.yml
RUN ansible-playbook /dotfiles/configuration/zsh_plugins.yml

# RUN ansible-playbook /dotfiles/configuration/programming_languages.yml
# RUN ansible-playbook /dotfiles/configuration/language_servers.yml

RUN ansible-playbook /dotfiles/configuration/python_dev.yml
RUN ansible-playbook /dotfiles/configuration/python_data_science.yml

# RUN nvim --headless "+Lazy! sync" +qa

WORKDIR /home/jeremypmann

ENTRYPOINT ["/bin/zsh", "--login"]
