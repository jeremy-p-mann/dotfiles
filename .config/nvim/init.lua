require('jer.plugins')
local nremap = require('jer.keymaps').nremap

vim.g.mapleader = " "
nremap(" ", "")

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

vim.api.nvim_exec(
[[
syntax enable

highlight ColorColumn ctermbg=0 guibg=lightgrey

let g:gruvbox_italicize_comments = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme duskfox
let test#strategy = 'vimux'
]],
false)


require('jer')


