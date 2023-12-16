FROM ubuntu:mantic


RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y python3-pip python3-dev && \
    apt-get install -y software-properties-common && \
    apt-get install -y ansible && \
    apt-get install -y git


RUN git clone https://github.com/jmann277/dotfiles --depth=1
RUN ansible-playbook /dotfiles/configuration/jeremy.yml
RUN ansible-playbook /dotfiles/configuration/install_packages.yml
RUN ansible-playbook /dotfiles/configuration/programming_languages.yml
RUN ansible-playbook /dotfiles/configuration/language_servers.yml
RUN ansible-playbook /dotfiles/configuration/python_dev.yml
RUN ansible-playbook /dotfiles/configuration/python_data_science.yml

USER jeremypmann

RUN ansible-playbook /dotfiles/configuration/install_dotfiles.yml
RUN ansible-playbook /dotfiles/configuration/zsh_plugins.yml

RUN nvim --headless "+Lazy! sync" +qa

# RUN git config --global user.name "Full Name"
# RUN git config --global user.email "email@address.com"

WORKDIR /home/jeremypmann

ENTRYPOINT ["/bin/zsh", "--login"]
