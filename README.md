
### htop.nvim

A simple Neovim plugin to open a floating window running `htop`. 

---
**Usage:** 
`:Htop` to open the floating window.
`q` to close the floating window.

---

#### Installation

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
