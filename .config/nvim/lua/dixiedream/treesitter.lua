local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    ensure_installed = {"bash", "c", "css", "dockerfile", "go", "javascript", "lua", "php", "python", "typescript", "vue" },
    highlight = {
        enable = true
    }
}
