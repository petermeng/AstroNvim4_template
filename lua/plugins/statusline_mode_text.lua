---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    status = {
      components = {
        mode = { mode_text = { padding = { left = 1, right = 1} } },
      }
    },
  },
}