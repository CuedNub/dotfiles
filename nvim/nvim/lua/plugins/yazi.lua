return {
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>-",
      "<cmd>Yazi<CR>",
      mode = { "n", "v" },
      desc = "Open yazi at current file",
    },
    {
      "<leader>yw",
      "<cmd>Yazi cwd<CR>",
      desc = "Open yazi in current working directory",
    },
    {
      "<leader>yr",
      "<cmd>Yazi toggle<CR>",
      desc = "Resume last yazi session",
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<F1>",
    },
  },
}
