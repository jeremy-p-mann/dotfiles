#!/bin/sh
npm i -g 
cargo install stylua
npm install -g \
    typescript \
    typescript-language-server \
    write-good \
    bash-language-server \
    prettier
pip3 install --upgrade python-lsp-server \
    pylsp-mypy \
    rope \
    pdbpp \
    pyls-black \
    proselint


