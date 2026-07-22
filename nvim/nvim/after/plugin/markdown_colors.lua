local function set_markdown_highlights()
  local hl = vim.api.nvim_set_hl

  -- Selection only for markdown window
  hl(0, "MarkdownVisual", { fg = "#1a2b2f", bg = "#7dcfff", bold = true })

  -- Headings
  hl(0, "@markup.heading.1.markdown", { fg = "#41a7fc", bold = true })
  hl(0, "@markup.heading.2.markdown", { fg = "#c3e88d", bold = true })
  hl(0, "@markup.heading.3.markdown", { fg = "#4fd6be", bold = true })
  hl(0, "@markup.heading.4.markdown", { fg = "#ffc777", bold = true })
  hl(0, "@markup.heading.5.markdown", { fg = "#bb9af7", bold = true })
  hl(0, "@markup.heading.6.markdown", { fg = "#737aa2", bold = true, italic = true })

  hl(0, "@markup.heading.1.marker.markdown", { fg = "#41a7fc", bold = true })
  hl(0, "@markup.heading.2.marker.markdown", { fg = "#c3e88d", bold = true })
  hl(0, "@markup.heading.3.marker.markdown", { fg = "#4fd6be", bold = true })
  hl(0, "@markup.heading.4.marker.markdown", { fg = "#ffc777", bold = true })
  hl(0, "@markup.heading.5.marker.markdown", { fg = "#bb9af7", bold = true })
  hl(0, "@markup.heading.6.marker.markdown", { fg = "#737aa2", bold = true, italic = true })

  -- List
  hl(0, "@markup.list.markdown", { fg = "#7aa2f7" })
  hl(0, "@markup.list.numbered.markdown", { fg = "#ff9e64" })
  hl(0, "@markup.list.checked.markdown", { fg = "#c3e88d" })
  hl(0, "@markup.list.unchecked.markdown", { fg = "#737aa2" })

  -- Text styles
  hl(0, "@markup.strong.markdown_inline", { fg = "#e0af68", bold = true })
  hl(0, "@markup.italic.markdown_inline", { fg = "#c3e88d", italic = true })
  hl(0, "@markup.strikethrough.markdown_inline", { fg = "#565f89", strikethrough = true })
  hl(0, "@text.markdown", { fg = "#ed8a6e" })

  -- Links
  hl(0, "@markup.link.markdown_inline", { fg = "#7dcfff", underline = true })
  hl(0, "@markup.link.label.markdown_inline", { fg = "#7dcfff", underline = true })
  hl(0, "@markup.link.url.markdown_inline", { fg = "#565f89", underline = true })

  -- Code
  hl(0, "@markup.raw.markdown_inline", { fg = "#ff9e64", bg = "#1e3a3a" })
  hl(0, "@markup.raw.block.markdown", { fg = "#a9b1d6", bg = "#162226" })

  -- Quote / rule
  hl(0, "@markup.quote.markdown", { fg = "#bb9af7", italic = true })
  hl(0, "@punctuation.special.markdown", { fg = "#3b4261" })

  -- render-markdown.nvim groups
  hl(0, "RenderMarkdownH1", { fg = "#41a7fc", bold = true })
  hl(0, "RenderMarkdownH2", { fg = "#c3e88d", bold = true })
  hl(0, "RenderMarkdownH3", { fg = "#4fd6be", bold = true })
  hl(0, "RenderMarkdownH4", { fg = "#ffc777", bold = true })
  hl(0, "RenderMarkdownH5", { fg = "#bb9af7", bold = true })
  hl(0, "RenderMarkdownH6", { fg = "#737aa2", bold = true, italic = true })

  hl(0, "RenderMarkdownBullet", { fg = "#7aa2f7" })
  hl(0, "RenderMarkdownUnchecked", { fg = "#737aa2" })
  hl(0, "RenderMarkdownChecked", { fg = "#c3e88d" })
  hl(0, "RenderMarkdownTodo", { fg = "#ffc777" })

  hl(0, "RenderMarkdownQuote", { fg = "#bb9af7", italic = true })
  hl(0, "RenderMarkdownDash", { fg = "#3b4261" })
  hl(0, "RenderMarkdownCode", { fg = "#a9b1d6", bg = "#162226" })
  hl(0, "RenderMarkdownCodeInline", { fg = "#ff9e64", bg = "#1e3a3a" })
  hl(0, "RenderMarkdownLink", { fg = "#7dcfff", underline = true })
end

local function apply_markdown_window(win)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end

  local buf = vim.api.nvim_win_get_buf(win)
  if vim.bo[buf].filetype ~= "markdown" then
    return
  end

  vim.wo[win].winhighlight = "Visual:MarkdownVisual"
end

local function refresh_all_markdown()
  set_markdown_highlights()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    apply_markdown_window(win)
  end
end

local group = vim.api.nvim_create_augroup("MarkdownCustomColors", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = group,
  callback = refresh_all_markdown,
})

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "WinEnter" }, {
  group = group,
  callback = function(args)
    if vim.bo[args.buf].filetype == "markdown" then
      set_markdown_highlights()
      apply_markdown_window(vim.api.nvim_get_current_win())
    end
  end,
})
