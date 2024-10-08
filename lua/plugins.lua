require("lazy").setup({

{
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = "VimEnter",
    },


'andweeb/presence.nvim',


 {
        "rebelot/kanagawa.nvim",
        as = "kangawa",
        config = function()
            require('kanagawa').setup({
                compile = false, -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {underline = true},
                transparent = false, -- do not set background color
                dimInactive = true, -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = { -- add/modify the #me and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors) -- add/modify highlights
                    return {}
                end,
                theme = "dragon", -- Load "wave" theme when 'background' option is not set
                background = { -- map the value of 'background' option to a theme
                    dark = "dragon", -- try "dragon" !
                    light = "lotus"
                },
            })
            overrides = function(colors)
                local theme = colors.theme
                return {
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },
                    TelescopeTitle = { fg = theme.ui.special, bold = true },
                    TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                    TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                }
            end
            vim.cmd("colorscheme kanagawa")
        end
    },
    {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  {"nvimtools/none-ls.nvim", 
    dependencies = {
       "nvim-lua/plenary.nvim"
       },
       event = "VeryLazy",
    opts = function()
        return require("none-ls")
    end,
   },
  {
   "amitds1997/remote-nvim.nvim",
   version = "*", -- Pin to GitHub releases
   dependencies = {
       "nvim-lua/plenary.nvim", -- For standard functions
       "MunifTanjim/nui.nvim", -- To build the plugin UI
       "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
   },
   config = true,
},
{
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
    config = function()
        require('distant'):setup()
    end
},
 {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  }
},


    {"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
 },
    'nvim-treesitter/playground',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'hrsh7th/nvim-cmp', -- Autocompletion plugin,
   'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp,
   'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
   'L3MON4D3/LuaSnip', -- Snippets plugin
        'simrat39/rust-tools.nvim',
  
  
  
    'mfussenegger/nvim-lint',

 {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    },



     "folke/which-key.nvim",
          { 'ojroques/nvim-hardline' },
    'neovim/nvim-lspconfig',
     {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function()
            require("project_nvim").setup({
                manual_mode = false,
                detection_methods = { "lsp", "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                ignore_lsp = {},
                exclude_dirs = {},
                show_hidden = true,
                silent_chdir = true,
                scope_chdir = 'global',
                datapath = vim.fn.stdpath("data"),
            })
        end,
    },
 {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- Function to get recent projects
            local function get_recent_projects()
                local project_nvim = require("project_nvim")
                local success, projects = pcall(project_nvim.get_recent_projects)
                projects = success and projects or {}

                local buttons = {}
                for _, project in ipairs(projects) do
                    local button = dashboard.button(project.name, "📁  " .. project.name, ":cd " .. project.path .. "<CR>")
                    table.insert(buttons, button)
                end
                return buttons
            end

            -- Set header
          
            -- Add default buttons
            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
                dashboard.button("n", "  New File", ":enew<CR>"),
                dashboard.button("p", "  Projects", ":Telescope projects<CR>"),
                dashboard.button("q", "  Quit", ":qa<CR>"),
            }

            -- Extend with recent projects
            local recent_projects_buttons = get_recent_projects()
            dashboard.section.buttons.val = vim.tbl_deep_extend("force", dashboard.section.buttons.val, recent_projects_buttons)


            -- Set up the dashboard
            alpha.setup(dashboard.opts)
        end,
    },
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
{ "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
{'mortepau/codicons.nvim'},

  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
   
    end
  },

},
})
