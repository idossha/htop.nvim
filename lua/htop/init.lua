
-- lua/htop/init.lua
local M = {}

-- Store configuration options (if needed later)
M.config = {}

-- A simple setup function to save user options
function M.setup(opts)
  M.config = opts or {}
end


function M.open()
  -- Create a new unlisted buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Calculate content dimensions (80% of the editor window)
  local content_width = math.floor(vim.o.columns * 0.8)
  local content_height = math.floor(vim.o.lines * 0.8)

  -- Account for the border: for "rounded" border, it's 1 cell on each side
  local border_width = 2  -- left + right
  local border_height = 2 -- top + bottom

  -- Total dimensions including border
  local total_width = content_width + border_width
  local total_height = content_height + border_height

  -- Calculate position to center the entire floating window
  local row = math.floor((vim.o.lines - total_height) / 2)
  local col = math.floor((vim.o.columns - total_width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = content_width,
    height = content_height,
    row = row,
    col = col,
    border = "rounded",
  }

  -- Open a floating window and capture its ID
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Launch htop in the terminal buffer
  vim.fn.termopen("htop")
  vim.cmd("startinsert")

  -- Create a function to close the window and delete the buffer
  local function close_all()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  -- Map 'q' in both normal and terminal modes to close the floating window and buffer.
  vim.keymap.set({ "n", "t" }, "q", function()
    -- If in terminal mode and still in insert, first exit terminal-insert mode.
    if vim.api.nvim_get_mode().mode:sub(1,1) == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
    end
    close_all()
  end, { buffer = buf, noremap = true, silent = true })
end

return M

