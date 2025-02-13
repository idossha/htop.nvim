
# htop.nvim

A simple Neovim plugin to open a floating window running `htop`.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  {
    "yourgithubusername/htop.nvim",
    config = function()
      require("htop").setup({})
      -- You can optionally override the key mapping here:
      vim.keymap.set("n", "<leader>HT", require("htop").open, { desc = "Open floating htop" })
    end,
  },
}
