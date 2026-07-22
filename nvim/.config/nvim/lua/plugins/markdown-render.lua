return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      latex = { enabled = false },
      heading = {
        sign = true,
        icons = { "󰼏 ", "󰎨 ", "󰼑 ", "󰎲 ", "󰼓 ", "󰎴 " },
        backgrounds = {},
      },
      bullet = {
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
        custom = {
          todo = {
            raw = "[-]",
            rendered = "󰥔 ",
            highlight = "RenderMarkdownTodo",
          },
        },
      },
      quote = {
        icon = "▋",
      },
      dash = {
        icon = "─",
      },
      code = {
        sign = false,
      },
    },
  },
}
