require('plugins')
require('impatient')
local nremap = require('jer.keymaps').nremap

vim.g.mapleader = " "
nremap(" ", "")

vim.g.do_filetype_lua = 1
vim.g.loaded_netrwPlugin = 0

local opt = vim.opt

opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.autoread = true
opt.swapfile = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.cursorline = true
opt.hidden = true
opt.showmode = true
opt.showcmd = true
opt.scrolloff = 3
opt.smartindent = true
opt.ai = true
opt.tabstop = 8
opt.softtabstop = 0
opt.expandtab = true
opt.shiftwidth  = 4
opt.smarttab = true
opt.splitbelow = true
opt.splitright = true
opt.background = 'dark'
opt.termguicolors = true
opt.colorcolumn = '80'
-- status line
opt.laststatus = 0
opt.showmode=false
opt.ruler=false
opt.laststatus=nil
opt.showcmd=false


vim.o.ch = 0
vim.o.ls = 0

require('jer')


