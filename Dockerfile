
FROM archlinux

RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman-key --init
RUN pacman-key --populate
RUN pacman-key --refresh-keys
RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S python python-pip python-setuptools git ansible

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

# RUN git config --global user.name "Full Name"
# RUN git config --global user.email "email@address.com"

WORKDIR /home/jeremypmann

# ENTRYPOINT ["/bin/zsh", "--login"]

