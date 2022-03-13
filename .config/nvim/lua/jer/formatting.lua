local nremap = require("jer.keymaps").nremap

nremap("<leader>fm", vim.lsp.buf.formatting, "LSP formatting")
nremap("<leader>af", [[gqk]], "Split long line into separate lines")
nremap("<leader>ws", require("jer.trim").trim_whitespace, "Trim Whitespace")
nremap("<leader>cc", require("telescope.builtin").colorscheme, "Telescope to Change Colorscheme")
