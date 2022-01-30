require("notify").setup {
  -- Animation style (see below for details)
  stages = "static",

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = "default",

  -- Default timeout for notifications
  timeout = 5000,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
  background_colour = "Normal",

  -- Minimum width for notification windows
  minimum_width = 50,

  -- Icons for the different levels
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
}

local M = {}

local async = require "plenary.async"
local notify = require("notify").async

M.tests = function()
  async.run(function()
    notify("Let's wait for this to close").close()
    notify "It closed!"
  end)
end

M.get_joke = function()
  async.run(function()
    local joke = vim.fn.system "dadjoke | cowsay"
    notify(joke)
  end)
end

return M
