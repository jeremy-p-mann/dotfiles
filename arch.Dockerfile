FROM archlinux

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S ansible

COPY configuration configuration
RUN ansible-playbook configuration/jeremy.yml
RUN ansible-playbook configuration/install_packages.yml
RUN ansible-playbook configuration/programming_languages.yml
RUN ansible-playbook configuration/language_servers.yml
RUN ansible-playbook configuration/python_dev.yml
RUN ansible-playbook configuration/python_data_science.yml

USER jeremypmann

RUN ansible-playbook configuration/install_dotfiles.yml
RUN ansible-playbook configuration/zsh_plugins.yml

# RUN git config --global user.name "Full Name"
# RUN git config --global user.email "email@address.com"

WORKDIR /home/jeremypmann

ENTRYPOINT ["/bin/zsh", "--login"]

