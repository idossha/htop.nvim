-- loads the module and commands for htop

-- Avoid reloading htop if already loaded
if vim.g.loaded_htop_plugin then
  return
end
vim.g.loaded_htop_plugin = true

-- create a user command so that users can type :Htop
vim.api.nvim_create_user_command("Htop", function()
  require("htop").open()
end, { desc = "Open floating htop" })

-- optionally, you can also set a default keymapping
-- comment this out if you prefer users to configure their own keymappings
-- vim.api.nvim_set_keymap("n", "<leader>HT", ":Htop<CR>", { noremap = true, silent = true })
