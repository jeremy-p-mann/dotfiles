#!/bin/sh
pip install python-lsp-server[all]
npm install -g typescript typescript-language-server
yarn global add yaml-language-server
pip3 install --upgrade python-lsp-server \
    pylsp-mypy \
    pyls-flake8 \
    rope \
    pyflakes \
    yapf \
    pdbpp \
