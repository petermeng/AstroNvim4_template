local uv = vim.uv or vim.loop
local cores = uv.available_parallelism and uv.available_parallelism() or 4
local ram_gb = math.floor((uv.get_total_memory() or 0) / 1024 / 1024 / 1024)

local jobs = math.max(2, math.floor(cores / 4))
local pch = ram_gb >= 48 and "memory" or "disk"

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    config = {
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--background-index-priority=background", -- don't outrank the test tooling
          "--header-insertion=never", -- per-CPU header variants: auto-insert guesses wrong
          "--completion-style=detailed",
          "--pch-storage=" .. pch,
          "-j=" .. jobs,
        },
      },
    },
  },
}