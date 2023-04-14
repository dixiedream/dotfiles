local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    ensure_installed = {"bash", "c", "css", "dockerfile", "go", "graphql", "javascript", "lua", "python", "typescript", "vue" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
}
