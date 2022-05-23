#!/bin/sh
# texlab is managed  
cargo install stylua
npm install -g \
    typescript \
    typescript-language-server \
    write-good \
    bash-language-server \
    vscode-langservers-extracted \
    prettier \
    dockerfile-language-server-nodejs
pip3 install --upgrade python-lsp-server \
    pylsp-mypy \
    rope \
    pdbpp \
    pyls-black \
    proselint


