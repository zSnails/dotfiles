-- vim.cmd [[language ja_JP]]

-- vim.g.gruvbox_material_background = 'hard'


vim.cmd([[
set background=dark
set termguicolors
colorscheme gruvbox
set noshowmode
set clipboard=unnamed
set cc=85
set noruler
set nowrap
"highlight Normal ctermbg=NONE guibg=NONE
nnoremap <silent><C-F11> :VimspectorReset<CR>
]])

vim.g.mapleader = " "
vim.g.vimspector_enable_mappings='HUMAN'
vim.g.laststatus = 3
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 7
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.showtabline = false
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.cmd [[packadd packer.nvim]]

require("packer").startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use 'puremourning/vimspector'

    use 'andweeb/presence.nvim'

    use 'neovim/nvim-lspconfig'
    use 'tpope/vim-commentary'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- pywal theme
    use 'dylanaraps/wal.vim'

    -- doki themes
    use 'doki-theme/doki-theme-vim'

    -- tokyo night theme
    use 'folke/tokyonight.nvim'

    -- gruvbox material theme
    use 'sainnhe/gruvbox-material'

    -- iceberg theme
    use 'cocopon/iceberg.vim'

    -- gruvbox theme
    use 'morhetz/gruvbox'

    -- kanagawa theme
    use "rebelot/kanagawa.nvim"

    -- nightgly theme
    use 'bluz71/vim-nightfly-guicolors'

    -- hex colors
    use 'chrisbra/Colorizer'

    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'nvim-treesitter/nvim-treesitter'

    -- yuck support
    use 'elkowar/yuck.vim'
end)

require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
    },
}


require("lualine").setup({
    options = {
        theme = 'gruvbox',
        section_separators = '',
        component_separators = '|',
    }
})


local servers = {
    "zls",
    "gopls",
    "jedi_language_server",
    "sumneko_lua",
    "clangd",
    "rls",
    "hls",
    "tsserver",
}

local function on_attach()
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting)
end

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})


for _, server in ipairs(servers) do
    require("lspconfig")[server].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                }
            },
            Python = {
                provideFormatter = true,
                pythonFormatter = "black"
            }
        }
    }
end
