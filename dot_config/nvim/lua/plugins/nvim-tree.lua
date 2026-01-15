return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      git = {
        enable = true,
        ignore = true,
      },
    }

    vim.keymap.set({ "n" }, "<C-m>", function()
      require("nvim-tree.api").tree.focus()
    end, { noremap = true, silent = true, desc = "NvimTreeにフォーカス" })
  end,
}