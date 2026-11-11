-- 1. Return your plugin list to lazy.nvim
local plugins = {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opt = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css"
      },
    },
  },

  -- Your permanent smear-cursor setup inside NvChad's plugin structure
  {
    "sphamba/smear-cursor.nvim",
    enabled = true, -- Keeps it permanently enabled
    lazy = false,   -- Forces NvChad to load it immediately on startup
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = false,
      cursor_color = "#6df8b2",
      particles_enabled = true,
      particle_max_num = 200,
      stiffness = 0.5,
      trailing_stiffness = 0.2,
      trailing_exponent = 5,
      damping = 0.6,
      gradient_exponent = 0,
      never_draw_over_target = true, 
      hide_target_hack = true,       
      particle_spread = 1,
      particles_per_second = 500,
      particles_per_length = 50,
      particle_max_lifetime = 800,
      particle_max_initial_velocity = 20,
      particle_velocity_from_cursor = 0.5,
      particle_damping = 0.15,
      particle_gravity = -50,
      min_distance_emit_particles = 0,
    },
    config = function(_, opts)
      require("smear_cursor").setup(opts)
      vim.api.nvim_set_hl(0, "SmearCursor", { fg = "#6df8b2", bg = "NONE" })
    end,
  },
}

-- 2. FORCE MATUGEN TO RUN UNCONDITIONALLY ON STARTUP
local status, matugen = pcall(require, "matugen")
if status then
  -- Wrap it in VimEnter to make sure it loads AFTER NvChad clears the screen
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      matugen.setup()
    end,
  })
end

return plugins

