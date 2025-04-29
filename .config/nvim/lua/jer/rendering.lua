local nremap = require "jer.keymaps".nremap

nremap("<leader>rd", require('snacks.image').hover, "Render/Hover image")
