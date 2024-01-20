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
RUN ansible-playbook /dotfiles/configuration/jeremy.yml -t user
RUN ansible-playbook /dotfiles/configuration/programming_languages.yml

USER jeremypmann

RUN ansible-playbook /dotfiles/configuration/jeremy.yml -t directory_structure

RUN mkdir -p /home/jeremypmann/.local/bin
RUN ln -s $(which fdfind) ~/.local/bin/fd

RUN ansible-playbook /dotfiles/configuration/install_dotfiles.yml
RUN ansible-playbook /dotfiles/configuration/zsh_plugins.yml

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

RUN ansible-playbook /dotfiles/configuration/language_servers.yml -t python

RUN ansible-playbook /dotfiles/configuration/python_dev.yml
RUN ansible-playbook /dotfiles/configuration/python_data_science.yml

RUN nvim --headless "+Lazy! sync" +qa
RUN nvim --headless "+30sleep" +qa

WORKDIR /home/jeremypmann

ENTRYPOINT ["/bin/zsh", "--login"]
