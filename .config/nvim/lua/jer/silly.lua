local nremap = require("jer.keymaps").nremap

nremap("<leader>tr", require("tarot").telescope_tarots, "Tarot")
nremap("<leader>asc", [[<CMD> FloatermNew! --height=0.999 --width=0.999 asciiquarium<CR>]], "Float asciiquarium")
nremap(
  "<leader>asl",
  [[<CMD>FloatermNew! --height=0.99 --width=0.99 asciiquarium \| lolcat<CR>]],
  "Float asciiquarium in lolcatz"
)
nremap("<leader>jo", require("jer.notify").get_joke, "Get A Joke")
nremap("<leader>nn", [[<CMD>lua require('notify')('hi')<CR>]])
