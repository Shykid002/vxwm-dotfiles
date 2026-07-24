 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#101417',
    base01 = '#1c2024',
    base02 = '#262a2e',
    base03 = '#8b9198',
    base04 = '#c1c7ce',
    base05 = '#dfe3e7',
    base06 = '#dfe3e7',
    base07 = '#dfe3e7',
    base08 = '#ffb4ab',
    base09 = '#cdc0e9',
    base0A = '#b6c9d8',
    base0B = '#93cdf6',
    base0C = '#cdc0e9',
    base0D = '#93cdf6',
    base0E = '#b6c9d8',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#dfe3e7',          bg = '#101417' })
  hi('TelescopeBorder',         { fg = '#8b9198',             bg = '#101417' })
  hi('TelescopePromptNormal',   { fg = '#dfe3e7',          bg = '#101417' })
  hi('TelescopePromptBorder',   { fg = '#8b9198',             bg = '#101417' })
  hi('TelescopePromptPrefix',   { fg = '#93cdf6',             bg = '#101417' })
  hi('TelescopePromptCounter',  { fg = '#c1c7ce',  bg = '#101417' })
  hi('TelescopePromptTitle',    { fg = '#101417',             bg = '#93cdf6' })
  hi('TelescopePreviewTitle',   { fg = '#101417',             bg = '#b6c9d8' })
  hi('TelescopeResultsTitle',   { fg = '#101417',             bg = '#cdc0e9' })
  hi('TelescopeSelection',      { fg = '#dfe3e7',          bg = '#262a2e' })
  hi('TelescopeSelectionCaret', { fg = '#93cdf6',             bg = '#262a2e' })
  hi('TelescopeMatching',       { fg = '#93cdf6',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
