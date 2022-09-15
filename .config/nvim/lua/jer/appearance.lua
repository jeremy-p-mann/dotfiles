vim.api.nvim_exec(
  [[
syntax enable

highlight ColorColumn ctermbg=0 guibg=lightgrey

let g:gruvbox_italicize_comments = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme carbonfox
]],
  false
)

local keymap = require "jer.keymaps"
local nremap = keymap.nremap
local colorscheme = require("telescope.builtin").colorscheme
local true_zen = require "true-zen"

require("dressing").setup {
  input = {
    relative = "editor",
    override = function(conf)
      return conf
    end,
  },
}

true_zen.setup {
  ui = {
    bottom = {
      laststatus = 0,
      ruler = false,
      showmode = false,
      showcmd = false,
      cmdheight = 1,
    },
    top = {
      showtabline = 0,
    },
    left = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
    },
  },
  modes = {
    ataraxis = {
      left_padding = 10,
      right_padding = 10,
      top_padding = 1,
      bottom_padding = 1,
      ideal_writing_area_width = { 0 },
      auto_padding = true,
      keep_default_fold_fillchars = true,
      custom_bg = { "none", "" },
      bg_configuration = true,
      quit = "untoggle",
      ignore_floating_windows = true,
      affected_higroups = {
        NonText = true,
        FoldColumn = true,
        ColorColumn = true,
        VertSplit = true,
        StatusLine = true,
        StatusLineNC = true,
        SignColumn = true,
      },
    },
    focus = {
      margin_of_error = 5,
      focus_method = "experimental",
    },
  },
  integrations = {
    vim_gitgutter = false,
    galaxyline = false,
    tmux = false,
    gitsigns = false,
    nvim_bufferline = false,
    limelight = false,
    twilight = false,
    vim_airline = false,
    vim_powerline = false,
    vim_signify = false,
    express_line = false,
    lualine = false,
    lightline = false,
    feline = false,
  },
  misc = {
    on_off_commands = false,
    ui_elements_commands = false,
    cursor_by_mode = false,
  },
}

local chill = function()
  vim.diagnostic.hide()
  vim.cmd [[TZMinimalist]]
end

local unchill = function()
  vim.diagnostic.show()
  vim.cmd [[TZMinimalist]]
end

nremap("<leader>co", chill, "Chill Out")
nremap("<leader>uc", unchill, "Unchill Out")
nremap("<leader>cl", [[:set cursorline<CR>]], "Turn on Cursor Line")
nremap("<leader>Cl", [[:set nocursorline<CR>]], "Turn off Cursor Line")
nremap("<leader>cc", colorscheme, "Telescope to Change Colorscheme")
