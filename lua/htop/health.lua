local M = {}

function M.check()
  local health = vim.health or require("health")
  local start = health.start or health.report_start
  local ok = health.ok or health.report_ok
  local warn = health.warn or health.report_warn
  local error = health.error or health.report_error

  start("htop.nvim")

  -- Check if htop is installed
  local htop_exists = vim.fn.executable("htop") == 1
  if htop_exists then
    ok("htop is installed")
  else
    error("htop is not installed. Please install htop: https://github.com/htop-dev/htop")
  end

  -- Check Neovim version
  local nvim_version = vim.version()
  local version_string = string.format("%d.%d.%d", nvim_version.major, nvim_version.minor, nvim_version.patch)
  
  if nvim_version.major > 0 or nvim_version.minor >= 8 then
    ok("Neovim version " .. version_string .. " supported")
  else
    warn("Neovim version " .. version_string .. " may not be fully supported. Recommended: 0.8.0+")
  end
end

return M