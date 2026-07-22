return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>cu",
        function()
          local ok, Snacks = pcall(require, "snacks")
          if not ok then
            vim.notify("snacks.nvim tidak tersedia", vim.log.levels.ERROR)
            return
          end

          local file_path = vim.fn.stdpath("config") .. "/lua/data/cheatsheet.md"
          if vim.fn.filereadable(file_path) == 0 then
            vim.notify("File cheatsheet tidak ditemukan:\n" .. file_path, vim.log.levels.ERROR)
            return
          end

          local items = {}

          for line in io.lines(file_path) do
            local kategori, keybinding, penjelasan = line:match("^|%s*(.-)%s*|%s*(.-)%s*|%s*(.-)%s*|%s*$")

            if kategori and keybinding and penjelasan then
              kategori = vim.trim(kategori)
              keybinding = vim.trim(keybinding)
              penjelasan = vim.trim(penjelasan)

              if kategori ~= "Kategori" and not kategori:match("^%-+$") then
                table.insert(items, {
                  text = table.concat({ kategori, keybinding, penjelasan }, " "),
                  kategori = kategori,
                  keybinding = keybinding,
                  penjelasan = penjelasan,
                })
              end
            end
          end

          if #items == 0 then
            vim.notify("Cheatsheet kosong atau format tabel tidak cocok.", vim.log.levels.WARN)
            return
          end

          Snacks.picker({
            title = "Cheatsheet",
            items = items,

            layout = {
              preset = "vertical",
            },

            format = function(item)
              return {
                { item.kategori or "-", "DiagnosticHint" },
                { " │ ", "Comment" },
                { item.keybinding or "-", "String" },
                { " │ ", "Comment" },
                { item.penjelasan or "-", "Normal" },
              }
            end,

            preview = function(ctx)
              local item = ctx.item
              local buf = ctx.buf

              if not item or not buf or not vim.api.nvim_buf_is_valid(buf) then
                return
              end

              local lines = {
                "Kategori   : " .. (item.kategori or "-"),
                "Keybinding : " .. (item.keybinding or "-"),
                "",
                "Penjelasan :",
                item.penjelasan or "-",
              }

              vim.bo[buf].modifiable = true
              vim.bo[buf].readonly = false
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
              vim.bo[buf].filetype = "markdown"
              vim.bo[buf].modifiable = false
              vim.bo[buf].readonly = true
            end,

            confirm = function(picker, item)
              picker:close()
              if not item then
                return
              end

              vim.api.nvim_echo({
                { "Kategori   : ", "DiagnosticHint" },
                { (item.kategori or "-") .. "\n", "Normal" },
                { "Keybinding : ", "String" },
                { (item.keybinding or "-") .. "\n", "Normal" },
                { "Penjelasan : ", "DiagnosticWarn" },
                { item.penjelasan or "-", "Normal" },
              }, true, {})
            end,
          })
        end,
        desc = "Cheat Sheet",
      },
    },
  },
}
