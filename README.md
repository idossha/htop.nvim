
# htop.nvim

A simple Neovim plugin to open a floating window running `htop`. 

hit `q` to close the floating window.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  {
    "idossha/htop.nvim",
    config = function()
      vim.keymap.set("n", "<leader>HT", require("htop").open, { desc = "Open floating htop" })
    end,
  },
}
