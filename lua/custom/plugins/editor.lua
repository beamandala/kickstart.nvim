return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          separator_style = 'slant',
          indicator = {
            style = 'underline',
          },
          diagnostics = 'nvim_lsp',
        },
      }

      vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Move to next buffer' })
      vim.keymap.set('n', '<C-[>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Move to previous buffer' })
      vim.keymap.set('n', '<leader>bb', '<cmd>BufferLinePick<CR>', { desc = 'Pick specific buffer' })
      vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close current buffer' })
    end,
  },

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {}

      vim.keymap.set('n', '<M-v>', function()
        local buf_name = vim.api.nvim_buf_get_name(0)

        if buf_name == 'terminal' then
          vim.cmd 'bdelete'
        else
          vim.cmd 'ToggleTerm size=40 direction=float name=terminal'
        end
      end, { desc = 'Open terminal' })
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup {}

      -- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
      vim.keymap.set('n', '-', function()
        local reveal_file = vim.fn.expand '%:p'
        if reveal_file == '' then
          reveal_file = vim.fn.getcwd()
        else
          local f = io.open(reveal_file, 'r')
          if f then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end

        require('neo-tree.command').execute {
          action = 'focus', -- OPTIONAL, this is the default value
          source = 'filesystem', -- OPTIONAL, this is the default value
          position = 'left', -- OPTIONAL, this is the default value
          reveal_file = reveal_file, -- path to file or folder to reveal
          reveal_force_cwd = true, -- change cwd without asking if needed
        }
      end, { desc = 'Open neo-tree at current file or working directory' })

      vim.keymap.set('n', '<C-`>', function()
        require('neo-tree.command').execute {
          toggle = true,
        }
      end, { desc = 'Toggle neotree' })
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.animate').setup()
      require('mini.cursorword').setup()
      require('mini.indentscope').setup()
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    config = function()
      require('nvim-ts-autotag').setup {
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
          filetypes = { 'html', 'js', 'ts', 'jsx', 'tsx', 'svelte' },
        },
      }
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },

  {
    'Pocco81/auto-save.nvim',
    lazy = false,
    config = function()
      require('auto-save').setup {}
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {}
    end,
  },

  {
    'simrat39/rust-tools.nvim',
    event = 'LspAttach',
    config = function()
      require('rust-tools').setup {
        hover_with_actions = true,
        autoSetHints = true,
      }
    end,
  },

  {
    'saecki/crates.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
}
