local nremap = require("jer.keymaps").nremap

nremap("<leader>tar", require("tarot").telescope_tarots, "Tarot")
nremap("<leader>asc", [[<CMD> FloatermNew! --height=0.999 --width=0.999 asciiquarium<CR>]], "Float asciiquarium")
local config = {
    fps = 35,
    name = 'snake',
}

-- init function is invoked only once at the start
-- config.init = function (grid)
--
-- end

-- update function
config.update = function (grid)
    for i = 1, #grid do
        local prev = grid[i][#(grid[i])]
        for j = 1, #(grid[i]) do
            grid[i][j], prev = prev, grid[i][j]
        end
    end
    return true
end


-- require("cellular-automaton").register_animation(config)

-- require("zone").setup()


vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
vim.keymap.set("n", "<leader>gol", "<cmd>CellularAutomaton game_of_life<CR>")
vim.keymap.set("n", "<leader>sn", "<cmd>CellularAutomaton snake<CR>")

            -- lkjasdlkfj
nremap(
  "<leader>asl",
  [[<CMD>FloatermNew! --height=0.99 --width=0.99 asciiquarium \| lolcat<CR>]],
        -- lkjasdlkfj                   lkadjf;lkjl;
  "Float asciiquarium in lolcatz"
)
                    -- lkjasdlkfj                   lkadjf;lkjl;
nremap("<leader>jo", require("jer.notify").get_joke, "Get A Joke")
nremap("<leader>nn", [[<CMD>lua require('notify')('hi')<CR>]])
        -- lkjasdlkfj                   lkadjf;lkjl;

