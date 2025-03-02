
-- lua/htop/init.lua
local M = {}

-- Default configuration
M.config = {
  width = 0.85,
  height = 0.85,
  border = "rounded",
  title = " htop ",
  title_pos = "center",
  command = "htop",
  keymaps = {
    close = "q",
    help = "?",
  },
  float_opts = {
    relative = "editor",
    style = "minimal",
    zindex = 50,
  },
}

-- Setup function to override default options
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.open()
  -- Create a new unlisted buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Calculate dimensions
  local width = math.floor(vim.o.columns * M.config.width)
  local height = math.floor(vim.o.lines * M.config.height)

  -- Account for the border
  local border_width = 2  -- left + right
  local border_height = 2 -- top + bottom

  -- Calculate total dimensions including border
  local total_width = width + border_width
  local total_height = height + border_height

  -- Center the window
  local row = math.floor((vim.o.lines - total_height) / 2)
  local col = math.floor((vim.o.columns - total_width) / 2)

  -- Create the window options
  local win_opts = vim.tbl_deep_extend("force", M.config.float_opts, {
    width = width,
    height = height,
    row = row,
    col = col,
    border = M.config.border,
    title = M.config.title,
    title_pos = M.config.title_pos,
  })

  -- Open a floating window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  -- Set window options for a better appearance
  vim.api.nvim_win_set_option(win, "winblend", 0)
  vim.api.nvim_win_set_option(win, "cursorline", true)
  
  -- Create highlight for the window
  if vim.fn.has("nvim-0.9") == 1 then
    -- Set window highlight groups
    vim.api.nvim_set_hl(0, "HtopBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "HtopNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "HtopTitle", { link = "Title" })
    
    -- Apply highlights to the window
    vim.api.nvim_win_set_option(win, "winhighlight", "Normal:HtopNormal,FloatBorder:HtopBorder,FloatTitle:HtopTitle")
  end

  -- Launch htop in the terminal buffer
  vim.fn.termopen(M.config.command)
  vim.cmd("startinsert")

  -- Function to close the window
  local function close_all()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  -- Set keymaps
  vim.keymap.set({ "n", "t" }, M.config.keymaps.close, function()
    -- If in terminal mode and in insert, exit terminal-insert mode
    if vim.api.nvim_get_mode().mode:sub(1,1) == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
    end
    close_all()
  end, { buffer = buf, noremap = true, silent = true })

  -- Set help keymap to show keybindings
  vim.keymap.set({ "n", "t" }, M.config.keymaps.help, function()
    vim.api.nvim_echo({
      { "htop.nvim keybindings:\n", "Title" },
      { M.config.keymaps.close .. ": ", "Identifier" }, { "Close htop\n", "Normal" },
      { M.config.keymaps.help .. ": ", "Identifier" }, { "Show this help", "Normal" },
    }, true, {})
  end, { buffer = buf, noremap = true, silent = true })

  -- Set buffer autocmd to close on BufLeave
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    once = true,
    callback = close_all,
  })
end

return M

