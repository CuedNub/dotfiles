return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "float",
      popup = {
        size = {
          height = "90%",
          width = "80%",
        },
        position = "40%",
        border = {
          style = "rounded",
          highlight = "NeoTreeFloatBorder",
        },
      },
    },
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
      },
      file_size = {
        enabled = true,
      },
      type = {
        enabled = true,
      },
      last_modified = {
        enabled = true,
      },
      git_status = {
        symbols = {
          added = "",
          modified = "",
          deleted = "",
          renamed = "",
          untracked = "",
        },
      },
    },
  },
  config = function(_, opts)
    local ayu = {
      orange = "#FF8F40",
      yellow = "#FFD173",
      green = "#AAD94C",
      blue = "#59C2FF",
      purple = "#D2A6FF",
      cyan = "#95E6CB",
      red = "#F07178",
      fg = "#BFBDB6",
      border = "#FFB454",
    }

    vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = ayu.border, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { fg = ayu.orange, bg = "NONE", bold = true })

    vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = ayu.yellow })
    vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = ayu.blue })
    vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = ayu.fg })
    vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = ayu.orange, bold = true })

    vim.api.nvim_set_hl(0, "NeoTreeFileSize", { fg = ayu.green })
    vim.api.nvim_set_hl(0, "NeoTreeFileType", { fg = ayu.purple })
    vim.api.nvim_set_hl(0, "NeoTreeLastModified", { fg = ayu.cyan })

    vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = ayu.green })
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = ayu.orange })
    vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = ayu.red })
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = ayu.purple })

    require("neo-tree").setup(opts)
  end,
}
