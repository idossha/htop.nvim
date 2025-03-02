
# htop.nvim

A modern Neovim plugin that opens htop (system monitoring) in a beautiful floating window.

![Demo](docs/htop.gif)

## Features

- Opens htop in a stylish floating window
- Configurable appearance (size, border, title)
- Custom keybindings
- Automatic window closing
- Health checking

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
return {
  {
    "idossha/htop.nvim",
    config = function()
      -- Default configuration
      require("htop").setup({
        -- window size (percentage of screen)
        width = 0.85,
        height = 0.85,
        
        -- window appearance
        border = "rounded",
        title = " htop ",
        title_pos = "center",
        
        -- command to run (can be changed to btop, etc.)
        command = "htop",
        
        -- keymaps
        keymaps = {
          close = "q",
          help = "?",
        },
      })
      
      -- Add a keymap to open htop
      vim.keymap.set("n", "<leader>HT", require("htop").open, { desc = "Open floating htop" })
    end,
  },
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "idossha/htop.nvim",
  config = function()
    require("htop").setup()
    vim.keymap.set("n", "<leader>HT", require("htop").open, { desc = "Open floating htop" })
  end
}
```

## Usage

- Run `:Htop` to open the floating window
- Press `q` to close the window
- Press `?` to show available keybindings

## Health Check

You can run `:checkhealth htop` to verify your installation and check if htop is available on your system.

## License

This project is licensed under MIT - see the LICENSE file for details.
