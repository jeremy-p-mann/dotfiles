FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install ansible



COPY configuration/install_packages.yml configuration/install_packages.yml
COPY configuration/packages.yml configuration/packages.yml
RUN ansible-playbook configuration/install_packages.yml

COPY configuration/programming_languages.yml configuration/programming_languages.yml
RUN ansible-playbook configuration/programming_languages.yml

COPY configuration/python_dev.yml configuration/python_dev.yml
RUN ansible-playbook configuration/python_dev.yml

COPY configuration/python_data_science.yml configuration/python_data_science.yml
RUN ansible-playbook configuration/python_data_science.yml

COPY configuration/language_servers.yml configuration/language_servers.yml
RUN ansible-playbook configuration/language_servers.yml

COPY configuration/jeremy.yml configuration/jeremy.yml
COPY configuration/folder_tree.yml configuration/folder_tree.yml
RUN ansible-playbook configuration/jeremy.yml


USER jeremypmann


COPY configuration/install_dotfiles.yml configuration/install_dotfiles.yml
RUN ansible-playbook configuration/install_dotfiles.yml

COPY configuration/zsh_plugins.yml configuration/zsh_plugins.yml
RUN ansible-playbook configuration/zsh_plugins.yml


# ENTRYPOINT ["/bin/zsh", "--login"]

