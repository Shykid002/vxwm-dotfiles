return {
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

  -- ADDED: Your permanent smear-cursor setup inside NvChad's plugin structure
  {
    "sphamba/smear-cursor.nvim",
    enabled = true, -- Keeps it permanently enabled
    lazy = false,   -- Forces NvChad to load it immediately on startup
    opts = {
      -- Terminal compatibility settings
      --cterm_cursor_colors = { 240, 245, 250, 255 },
      --cterm_bg = 235,
    
      -- Behavior adjustments
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = false,

      -- Fire Hazard settings
   -- cursor_color = "#ff4000",
   -- cursor_color = "#00f0ff",
   -- cursor_color = "#ff8800",
      cursor_color = "#6df8b2",
   -- cursor_color = "#c578dc",
      particles_enabled = true,
      particle_max_num = 200,
      stiffness = 0.5,
      trailing_stiffness = 0.2,
      trailing_exponent = 5,
      damping = 0.6,
      gradient_exponent = 0,

      -- Target tracking fixes
      never_draw_over_target = true, 
      hide_target_hack = true,       
      
      -- Particle physics
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

     -- Force highlights to refresh after NvChad's Base46 theme finishes loading
    config = function(_, opts)
      require("smear_cursor").setup(opts)
      vim.api.nvim_set_hl(0, "SmearCursor", { fg = "#6df8b2", bg = "NONE" })
    end,
  },
}











