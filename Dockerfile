FROM archlinux:latest

RUN pacman --quiet --noconfirm -Syu

RUN pacman -S --noconfirm ansible git zsh

RUN useradd \
    --shell /bin/zsh \
    --home-dir /home/jeremypmann \
    --password '' \
    jeremypmann
USER jeremypmann
WORKDIR /home/jeremypmann

RUN git clone https://github.com/jmann277/dotfiles
WORKDIR /home/jeremypmann/dotfiles
RUN ansible-playbook configuration/install_dotfiles.yml
RUN ansible-playbook configuration/zsh_plugins.yml

RUN git fetch --all
RUN git checkout dockerfile

USER root
RUN ansible-playbook configuration/essential_packages.yml
USER jeremypmann


WORKDIR /home/jeremypmann
ENTRYPOINT ["/bin/zsh", "--login"]

