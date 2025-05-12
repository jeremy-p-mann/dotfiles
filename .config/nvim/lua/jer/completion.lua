local keymap = require "jer.keymaps"
local iremap = keymap.iremap
local bl = require('blink.cmp')


iremap('<C-b>', function() bl.show({ providers = { 'buffer' } }) end, 'Complete From Buffer')
iremap('<C-p>', function() bl.show({ providers = { 'lsp' } }) end, 'Complete From LSP')
iremap('<C-f>', function() bl.show({ providers = { 'path' } }) end, 'Complete From File')
iremap('<C-d>', function() bl.show({ providers = { 'snippets' } }) end, 'Complete From Snippets')
