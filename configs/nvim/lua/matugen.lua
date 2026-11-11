 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#fff8f2',
    base01 = '#f5ede3',
    base02 = '#efe7de',
    base03 = '#7f7667',
    base04 = '#4d4638',
    base05 = '#1e1b16',
    base06 = '#1e1b16',
    base07 = '#1e1b16',
    base08 = '#ba1a1a',
    base09 = '#546429',
    base0A = '#6c5c3d',
    base0B = '#775a14',
    base0C = '#bbce87',
    base0D = '#e8c172',
    base0E = '#d9c49e',
    base0F = '#f6e0b8',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#1e1b16',          bg = '#fff8f2' })
  hi('TelescopeBorder',         { fg = '#7f7667',             bg = '#fff8f2' })
  hi('TelescopePromptNormal',   { fg = '#1e1b16',          bg = '#fff8f2' })
  hi('TelescopePromptBorder',   { fg = '#7f7667',             bg = '#fff8f2' })
  hi('TelescopePromptPrefix',   { fg = '#775a14',             bg = '#fff8f2' })
  hi('TelescopePromptCounter',  { fg = '#4d4638',  bg = '#fff8f2' })
  hi('TelescopePromptTitle',    { fg = '#fff8f2',             bg = '#775a14' })
  hi('TelescopePreviewTitle',   { fg = '#fff8f2',             bg = '#6c5c3d' })
  hi('TelescopeResultsTitle',   { fg = '#fff8f2',             bg = '#546429' })
  hi('TelescopeSelection',      { fg = '#1e1b16',          bg = '#efe7de' })
  hi('TelescopeSelectionCaret', { fg = '#775a14',             bg = '#efe7de' })
  hi('TelescopeMatching',       { fg = '#775a14',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#1e1b16',          bg = '#fff8f2' })
  hi('MiniPickBorder',         { fg = '#7f7667',             bg = '#fff8f2' })
  hi('MiniPickPrompt',   { fg = '#1e1b16',          bg = '#fff8f2' })
  hi('MiniPickPromptPrefix',   { fg = '#775a14',             bg = '#fff8f2' })
  hi('MiniPickBorderText',    { fg = '#fff8f2',             bg = '#775a14' })
  hi('MiniPickMatchCurrent',      { fg = '#1e1b16',          bg = '#efe7de' })
  hi('MiniPickPromptCaret', { fg = '#775a14',             bg = '#efe7de' })
  hi('MiniPickMatchRanges',       { fg = '#775a14',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
