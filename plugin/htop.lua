-- loads the module and commands for htop

-- Avoid reloading htop if already loaded
if vim.g.loaded_htop_plugin then
  return
end
vim.g.loaded_htop_plugin = true

-- Create a user command so that users can type :Htop
vim.api.nvim_create_user_command("Htop", function()
  require("htop").open()
end, { desc = "Open floating htop" })

-- Register the health check module
vim.health = vim.health or {}
vim.health.htop = require("htop.health")
