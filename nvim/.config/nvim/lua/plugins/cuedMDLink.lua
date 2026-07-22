return {
  {
    "folke/snacks.nvim",
    init = function()
      local nvim_extensions = {
        md = true,
        txt = true,
        lua = true,
        vim = true,
        json = true,
        yaml = true,
        yml = true,
        toml = true,
        ini = true,
        conf = true,
        cfg = true,
        sh = true,
        bash = true,
        zsh = true,
        fish = true,
        py = true,
        js = true,
        ts = true,
        jsx = true,
        tsx = true,
        html = true,
        css = true,
        scss = true,
        c = true,
        h = true,
        cpp = true,
        hpp = true,
        rs = true,
        go = true,
        java = true,
        kt = true,
        rb = true,
        php = true,
        sql = true,
        xml = true,
        csv = true,
        log = true,
      }

      local group = vim.api.nvim_create_augroup("cuedMDLink", { clear = true })

      local function notify(msg, level)
        vim.notify("[cuedMDLink] " .. msg, level or vim.log.levels.INFO)
      end

      local function normalize(path)
        local expanded = vim.fn.expand(path)
        local absolute = vim.fn.fnamemodify(expanded, ":p")
        return vim.fs.normalize(absolute)
      end

      local function to_home_path(path)
        local home = normalize("~")
        local abs = normalize(path)

        if abs == home then
          return "~"
        end

        local prefix = home .. "/"
        if abs:sub(1, #prefix) == prefix then
          return "~/" .. abs:sub(#prefix + 1)
        end

        return abs
      end

      local function scan_files(root_dir)
        local items = {}
        local abs_root = normalize(root_dir)

        if vim.fn.isdirectory(abs_root) == 0 then
          notify("Folder tidak ditemukan: " .. root_dir, vim.log.levels.ERROR)
          return items
        end

        local files = vim.fn.globpath(abs_root, "**/*", true, true)
        table.sort(files)

        for _, f in ipairs(files) do
          local abs_f = normalize(f)
          if vim.fn.filereadable(abs_f) == 1 then
            table.insert(items, {
              path = abs_f,
              display = abs_f:sub(#abs_root + 2),
              ordinal = abs_f,
            })
          end
        end

        return items
      end

      local function get_visual_context(bufnr)
        local mode = vim.fn.mode()
        if mode ~= "v" then
          notify("Gunakan visual character mode (`v`).", vim.log.levels.WARN)
          return nil
        end

        local start_pos = vim.fn.getpos("v")
        local cur = vim.api.nvim_win_get_cursor(0)

        local srow = start_pos[2] - 1
        local scol = start_pos[3] - 1
        local erow = cur[1] - 1
        local ecol = cur[2]

        if srow > erow or (srow == erow and scol > ecol) then
          srow, erow = erow, srow
          scol, ecol = ecol, scol
        end

        local lines = vim.api.nvim_buf_get_text(bufnr, srow, scol, erow, ecol + 1, {})
        local text = table.concat(lines, "\n")

        if text:find("\n") then
          notify("Versi awal hanya mendukung anchor text satu baris.", vim.log.levels.WARN)
          return nil
        end

        vim.cmd("normal! \27")

        return {
          text = text,
          srow = srow,
          scol = scol,
          erow = erow,
          ecol = ecol + 1,
        }
      end

      local function get_normal_context()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line = vim.api.nvim_get_current_line()
        local row = cursor[1] - 1
        local col = cursor[2] + 1

        if line == "" then
          notify("Baris kosong. Letakkan kursor pada anchor text.", vim.log.levels.WARN)
          return nil
        end

        if col > #line then
          col = #line
        end

        if col < 1 then
          notify("Letakkan kursor pada anchor text.", vim.log.levels.WARN)
          return nil
        end

        if line:sub(col, col):match("%s") then
          notify("Kursor harus berada tepat di anchor text.", vim.log.levels.WARN)
          return nil
        end

        local s = line:sub(1, col):find("%S+$")
        if not s then
          notify("Anchor text tidak ditemukan.", vim.log.levels.WARN)
          return nil
        end

        local e = line:find("%s", col)
        if not e then
          e = #line + 1
        end

        return {
          text = line:sub(s, e - 1),
          srow = row,
          scol = s - 1,
          erow = row,
          ecol = e - 1,
        }
      end

      local function create_link_from_folder(label, folder)
        local bufnr = vim.api.nvim_get_current_buf()
        local source_file = vim.api.nvim_buf_get_name(bufnr)
        if source_file == "" then
          notify("Simpan file ini dulu.", vim.log.levels.ERROR)
          return
        end

        local mode = vim.fn.mode()
        local ctx

        if mode == "v" or mode == "V" or mode == "\22" then
          ctx = get_visual_context(bufnr)
        else
          ctx = get_normal_context()
        end

        if not ctx then
          return
        end

        local items = scan_files(folder)
        if #items == 0 then
          notify("Tidak ada file di " .. folder, vim.log.levels.WARN)
          return
        end

        require("snacks").picker.select(items, {
          prompt = "Link " .. label .. " (" .. folder .. ")",
          format_item = function(item)
            return item.display
          end,
        }, function(item)
          if not item then
            return
          end

          local link_path = to_home_path(item.path)
          local link = string.format("[%s](%s)", ctx.text, link_path)

          vim.api.nvim_buf_set_text(bufnr, ctx.srow, ctx.scol, ctx.erow, ctx.ecol, { link })
        end)
      end

      local function find_markdown_link_at_cursor()
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2] + 1

        for s, _, path, e in line:gmatch("()(%b[])%((.-)%)()") do
          if col >= s and col < e then
            return path
          end
        end

        return nil
      end

      local function resolve_link_path(raw_path)
        if not raw_path or raw_path == "" then
          return nil
        end

        local path = raw_path
        path = path:gsub("^<", ""):gsub(">$", "")
        path = path:gsub("#.*$", "")

        if path:match("^%a[%w+.-]*://") or path:match("^mailto:") then
          notify("Link eksternal tidak didukung oleh gf plugin ini.", vim.log.levels.WARN)
          return nil
        end

        if path:sub(1, 1) == "~" or path:match("^/") then
          return normalize(path)
        end

        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file == "" then
          notify("Simpan file ini dulu agar path relatif bisa dibuka.", vim.log.levels.ERROR)
          return nil
        end

        local base_dir = vim.fn.fnamemodify(current_file, ":h")
        return normalize(base_dir .. "/" .. path)
      end

      local function open_with_system(abs_path)
        vim.fn.jobstart({ "xdg-open", abs_path }, { detach = true })
      end

      local function smart_gf()
        local raw_path = find_markdown_link_at_cursor()

        if not raw_path then
          vim.cmd("normal! gf")
          return
        end

        local abs_path = resolve_link_path(raw_path)
        if not abs_path then
          return
        end

        if vim.fn.filereadable(abs_path) == 0 then
          notify("File tidak ditemukan: " .. abs_path, vim.log.levels.ERROR)
          return
        end

        local ext = vim.fn.fnamemodify(abs_path, ":e"):lower()

        if nvim_extensions[ext] then
          vim.cmd("edit " .. vim.fn.fnameescape(abs_path))
        else
          open_with_system(abs_path)
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "markdown",
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }

          vim.keymap.set({ "n", "x" }, "<leader>md", function()
            create_link_from_folder("Doc", "~/Documents")
          end, vim.tbl_extend("force", opts, { desc = "cuedMDLink: link dari ~/Documents" }))

          vim.keymap.set({ "n", "x" }, "<leader>mp", function()
            create_link_from_folder("Pic", "~/Pictures")
          end, vim.tbl_extend("force", opts, { desc = "cuedMDLink: link dari ~/Pictures" }))

          vim.keymap.set(
            "n",
            "gf",
            smart_gf,
            vim.tbl_extend("force", opts, {
              desc = "cuedMDLink: buka link Markdown / file",
            })
          )
        end,
      })
    end,
  },
}
