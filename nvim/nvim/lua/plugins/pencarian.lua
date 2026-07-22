-- ============================================================================
-- KAMUS KEYBINDING LAZYVIM (BAHASA INDONESIA)
-- ============================================================================
-- File    : ~/.config/nvim/lua/plugins/pencarian.lua
-- Fungsi  : Popup pencarian keybinding dengan penjelasan Bahasa Indonesia
-- Trigger : <leader>hk
-- ============================================================================

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>hk",
      function()
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local previewers = require("telescope.previewers")

        -- ====================================================================
        -- DAFTAR KEYBINDING LAZYVIM (BAHASA INDONESIA)
        -- Silakan tambah/edit sesuai kebutuhan Anda
        -- ====================================================================
        local keybinds_data = {

          -- [ FILE & BUFFER ] ------------------------------------------------
          {
            key = "<leader>ff",
            desc = "Mencari File: Membuka popup untuk mencari file di dalam proyek berdasarkan nama file.",
          },
          { key = "<leader>fr", desc = "File Terbaru: Menampilkan daftar file yang baru saja dibuka/diedit." },
          { key = "<leader>fb", desc = "Cari Buffer: Mencari dan berpindah ke buffer (file) yang sedang terbuka." },
          { key = "<leader>fn", desc = "File Baru: Membuat file kosong baru di tab/buffer baru." },
          { key = "<leader>e", desc = "File Explorer: Membuka/menutup panel folder Neo-tree di sebelah kiri." },
          { key = "<leader>E", desc = "File Explorer (Root): Membuka Neo-tree di direktori root proyek." },
          {
            key = "<leader>bd",
            desc = "Hapus Buffer: Menutup buffer (file) yang sedang aktif tanpa keluar dari Neovim.",
          },
          { key = "<leader>bo", desc = "Hapus Buffer Lain: Menutup semua buffer kecuali yang sedang aktif." },
          { key = "<leader>bb", desc = "Pindah Buffer: Menampilkan daftar buffer untuk berpindah dengan cepat." },
          { key = "<S-h>", desc = "Buffer Sebelumnya: Pindah ke tab buffer di sebelah kiri." },
          { key = "<S-l>", desc = "Buffer Selanjutnya: Pindah ke tab buffer di sebelah kanan." },

          -- [ PENCARIAN & GREP ] ---------------------------------------------
          {
            key = "<leader>sg",
            desc = "Live Grep: Mencari kata/kalimat di seluruh isi file dalam proyek. Sangat berguna untuk mencari fungsi atau variabel.",
          },
          {
            key = "<leader>sw",
            desc = "Cari Kata (Cursor): Mencari kata yang sedang berada di bawah kursor ke seluruh proyek.",
          },
          {
            key = "<leader>ss",
            desc = "Cari Simbol: Mencari simbol (fungsi, variabel, class) di file yang sedang aktif.",
          },
          { key = "<leader>sS", desc = "Cari Simbol (Workspace): Mencari simbol di seluruh proyek/workspace." },
          {
            key = "<leader>sr",
            desc = "Search & Replace: Membuka Spectre untuk mencari dan mengganti teks di banyak file sekaligus.",
          },
          { key = "<leader>/", desc = "Grep Root: Mencari teks di direktori root proyek." },
          { key = "<leader>sd", desc = "Cari Diagnostics: Menampilkan daftar error/warning di file aktif." },
          {
            key = "<leader>sD",
            desc = "Cari Diagnostics (Workspace): Menampilkan semua error/warning di seluruh proyek.",
          },
          { key = "<leader>sh", desc = "Cari Help: Mencari topik di dokumentasi bantuan Neovim." },
          { key = "<leader>sk", desc = "Cari Keymaps: Mencari semua keybinding yang terdaftar (versi Inggris)." },
          { key = "<leader>sm", desc = "Cari Marks: Menampilkan daftar bookmark/marks yang sudah dibuat." },
          { key = "<leader>so", desc = "Cari Options: Mencari dan mengubah opsi/pengaturan Neovim." },

          -- [ KODE & LSP ] ---------------------------------------------------
          { key = "gd", desc = "Go to Definition: Melompat ke lokasi di mana fungsi/variabel didefinisikan." },
          { key = "gr", desc = "Go to References: Menampilkan semua lokasi di mana fungsi/variabel digunakan." },
          { key = "gI", desc = "Go to Implementation: Melompat ke implementasi interface/abstract class." },
          { key = "gy", desc = "Go to Type: Melompat ke definisi tipe data dari variabel." },
          { key = "gD", desc = "Go to Declaration: Melompat ke deklarasi fungsi/variabel." },
          { key = "K", desc = "Hover Info: Menampilkan dokumentasi/informasi tentang fungsi di bawah kursor." },
          { key = "gK", desc = "Signature Help: Menampilkan parameter yang dibutuhkan fungsi saat mengetik." },
          {
            key = "<leader>ca",
            desc = "Code Action: Menampilkan saran perbaikan otomatis dari LSP (import, fix error, refactor, dll).",
          },
          {
            key = "<leader>cr",
            desc = "Rename: Mengubah nama variabel/fungsi di seluruh proyek secara otomatis dan aman.",
          },
          { key = "<leader>cf", desc = "Format: Merapikan format kode sesuai standar (indentasi, spasi, dll)." },
          { key = "<leader>cd", desc = "Line Diagnostics: Menampilkan detail error/warning pada baris kursor." },
          { key = "<leader>cl", desc = "LSP Info: Menampilkan informasi Language Server yang sedang aktif." },
          { key = "]d", desc = "Diagnostic Berikutnya: Melompat ke error/warning selanjutnya." },
          { key = "[d", desc = "Diagnostic Sebelumnya: Melompat ke error/warning sebelumnya." },
          { key = "]e", desc = "Error Berikutnya: Melompat ke error selanjutnya (skip warning)." },
          { key = "[e", desc = "Error Sebelumnya: Melompat ke error sebelumnya (skip warning)." },

          -- [ WINDOW & SPLIT ] -----------------------------------------------
          { key = "<leader>-", desc = "Split Horizontal: Membagi layar secara horizontal (atas-bawah)." },
          { key = "<leader>|", desc = "Split Vertikal: Membagi layar secara vertikal (kiri-kanan)." },
          { key = "<leader>wd", desc = "Hapus Window: Menutup window/split yang sedang aktif." },
          { key = "<leader>wm", desc = "Maximize Window: Memperbesar window aktif ke layar penuh (toggle)." },
          { key = "<C-h>", desc = "Pindah Window Kiri: Memindahkan kursor ke window sebelah kiri." },
          { key = "<C-j>", desc = "Pindah Window Bawah: Memindahkan kursor ke window sebelah bawah." },
          { key = "<C-k>", desc = "Pindah Window Atas: Memindahkan kursor ke window sebelah atas." },
          { key = "<C-l>", desc = "Pindah Window Kanan: Memindahkan kursor ke window sebelah kanan." },
          { key = "<C-Up>", desc = "Resize Window (Atas): Memperbesar tinggi window ke atas." },
          { key = "<C-Down>", desc = "Resize Window (Bawah): Memperkecil tinggi window." },
          { key = "<C-Left>", desc = "Resize Window (Kiri): Memperkecil lebar window." },
          { key = "<C-Right>", desc = "Resize Window (Kanan): Memperbesar lebar window ke kanan." },

          -- [ TAB ] ----------------------------------------------------------
          { key = "<leader><tab>l", desc = "Tab Terakhir: Pindah ke tab terakhir yang dibuka." },
          { key = "<leader><tab>f", desc = "Tab Pertama: Pindah ke tab paling pertama." },
          { key = "<leader><tab><tab>", desc = "Tab Baru: Membuat tab baru." },
          { key = "<leader><tab>d", desc = "Hapus Tab: Menutup tab yang sedang aktif." },
          { key = "<leader><tab>]", desc = "Tab Berikutnya: Pindah ke tab selanjutnya." },
          { key = "<leader><tab>[", desc = "Tab Sebelumnya: Pindah ke tab sebelumnya." },

          -- [ GIT ] ----------------------------------------------------------
          { key = "<leader>gg", desc = "Lazygit: Membuka antarmuka Git interaktif (commit, push, pull, branch, dll)." },
          { key = "<leader>gG", desc = "Lazygit (Root): Membuka Lazygit di direktori root proyek." },
          { key = "<leader>gb", desc = "Git Blame: Menampilkan siapa yang terakhir mengubah setiap baris kode." },
          { key = "<leader>gf", desc = "Git File History: Melihat riwayat perubahan file yang sedang dibuka." },
          { key = "<leader>gc", desc = "Git Commits: Menampilkan daftar semua commit di repository." },
          { key = "<leader>gs", desc = "Git Status: Menampilkan file yang berubah (modified, staged, untracked)." },
          { key = "]h", desc = "Hunk Berikutnya: Melompat ke perubahan Git selanjutnya di file." },
          { key = "[h", desc = "Hunk Sebelumnya: Melompat ke perubahan Git sebelumnya di file." },
          { key = "<leader>ghp", desc = "Preview Hunk: Menampilkan preview perubahan pada baris kursor." },
          { key = "<leader>ghr", desc = "Reset Hunk: Membatalkan perubahan pada baris/blok kode yang dipilih." },
          { key = "<leader>ghs", desc = "Stage Hunk: Menambahkan perubahan baris/blok ke staging area." },

          -- [ UI & TOGGLE ] --------------------------------------------------
          { key = "<leader>uf", desc = "Toggle Format: Mengaktifkan/menonaktifkan auto-format saat save." },
          { key = "<leader>us", desc = "Toggle Spelling: Mengaktifkan/menonaktifkan pengecekan ejaan." },
          { key = "<leader>uw", desc = "Toggle Wrap: Mengaktifkan/menonaktifkan word wrap (teks turun otomatis)." },
          { key = "<leader>ul", desc = "Toggle Line Numbers: Mengaktifkan/menonaktifkan nomor baris." },
          { key = "<leader>ud", desc = "Toggle Diagnostics: Menyembunyikan/menampilkan error & warning." },
          { key = "<leader>uc", desc = "Toggle Conceal: Menyembunyikan/menampilkan karakter tersembunyi." },
          { key = "<leader>uh", desc = "Toggle Inlay Hints: Menampilkan/menyembunyikan hint tipe data." },
          { key = "<leader>uT", desc = "Toggle Treesitter: Mengaktifkan/menonaktifkan syntax highlighting." },
          { key = "<leader>ub", desc = "Toggle Background: Mengubah tema terang/gelap." },
          { key = "<leader>un", desc = "Dismiss Notifications: Menghapus semua notifikasi yang muncul." },

          -- [ TERMINAL ] -----------------------------------------------------
          { key = "<leader>ft", desc = "Terminal (Root): Membuka terminal di direktori root proyek." },
          { key = "<leader>fT", desc = "Terminal (CWD): Membuka terminal di direktori file aktif." },
          { key = "<C-/>", desc = "Toggle Terminal: Membuka/menutup terminal floating." },
          { key = "<C-_>", desc = "Toggle Terminal (Alt): Alternatif tombol toggle terminal." },
          { key = "<Esc><Esc>", desc = "Exit Terminal Mode: Keluar dari mode terminal ke mode normal." },

          -- [ QUIT & SESSION ] -----------------------------------------------
          { key = "<leader>qq", desc = "Quit All: Keluar dari Neovim (menutup semua file)." },
          { key = "<leader>qs", desc = "Restore Session: Memulihkan sesi terakhir (file yang terbuka sebelumnya)." },
          { key = "<leader>ql", desc = "Restore Last Session: Memulihkan sesi terakhir dari direktori manapun." },
          { key = "<leader>qd", desc = "Don't Save Session: Keluar tanpa menyimpan sesi." },

          -- [ LAZY & MASON ] -------------------------------------------------
          { key = "<leader>l", desc = "Lazy: Membuka plugin manager untuk update/install plugin." },
          { key = "<leader>cm", desc = "Mason: Membuka installer untuk LSP, Formatter, dan Linter." },

          -- [ MODE VISUAL ] --------------------------------------------------
          { key = "v", desc = "Visual Mode: Masuk mode seleksi per karakter." },
          { key = "V", desc = "Visual Line: Masuk mode seleksi per baris." },
          { key = "<C-v>", desc = "Visual Block: Masuk mode seleksi blok/kolom (untuk edit multi-baris)." },
          { key = ">", desc = "Indent Kanan: Menggeser teks yang dipilih ke kanan." },
          { key = "<", desc = "Indent Kiri: Menggeser teks yang dipilih ke kiri." },
          { key = "J", desc = "Gabung Baris: Menggabungkan baris yang dipilih menjadi satu baris." },

          -- [ NAVIGASI DASAR ] -----------------------------------------------
          { key = "gg", desc = "Ke Awal File: Melompat ke baris pertama file." },
          { key = "G", desc = "Ke Akhir File: Melompat ke baris terakhir file." },
          { key = "{", desc = "Paragraf Sebelumnya: Melompat ke paragraf/blok kode sebelumnya." },
          { key = "}", desc = "Paragraf Berikutnya: Melompat ke paragraf/blok kode selanjutnya." },
          { key = "%", desc = "Pasangan Bracket: Melompat ke kurung/bracket pasangannya." },
          { key = "*", desc = "Cari Kata (Maju): Mencari kata di bawah kursor ke arah bawah." },
          { key = "#", desc = "Cari Kata (Mundur): Mencari kata di bawah kursor ke arah atas." },
          { key = "zz", desc = "Tengahkan Layar: Menggeser layar agar kursor berada di tengah." },
          { key = "<C-d>", desc = "Scroll Bawah: Menggeser setengah layar ke bawah." },
          { key = "<C-u>", desc = "Scroll Atas: Menggeser setengah layar ke atas." },

          -- [ EDITING ] ------------------------------------------------------
          { key = "u", desc = "Undo: Membatalkan perubahan terakhir." },
          { key = "<C-r>", desc = "Redo: Mengulangi perubahan yang dibatalkan." },
          { key = "yy", desc = "Copy Baris: Menyalin seluruh baris ke clipboard." },
          { key = "dd", desc = "Hapus Baris: Menghapus (cut) seluruh baris." },
          { key = "p", desc = "Paste Setelah: Menempelkan teks setelah kursor." },
          { key = "P", desc = "Paste Sebelum: Menempelkan teks sebelum kursor." },
          { key = "ciw", desc = "Change Word: Menghapus kata dan masuk mode insert." },
          { key = "caw", desc = "Change Around Word: Menghapus kata beserta spasi dan masuk insert." },
          { key = 'ci"', desc = "Change Inside Quotes: Mengubah teks di dalam tanda kutip." },
          { key = "di(", desc = "Delete Inside Parens: Menghapus isi di dalam kurung." },
          { key = "gc", desc = "Comment Toggle: Menjadikan baris sebagai komentar atau sebaliknya." },
          { key = "gcc", desc = "Comment Line: Toggle komentar pada baris kursor." },
        }

        -- ====================================================================
        -- MENGURUTKAN DATA BERDASARKAN DESKRIPSI (A-Z)
        -- ====================================================================
        table.sort(keybinds_data, function(a, b)
          return a.desc:lower() < b.desc:lower()
        end)

        -- ====================================================================
        -- MEMBUAT PICKER TELESCOPE
        -- ====================================================================
        pickers
          .new({}, {
            prompt_title = "🔍 Kamus Keybinding LazyVim (Bahasa Indonesia)",
            results_title = "Daftar Keybinding",
            preview_title = "Detail Penjelasan",

            finder = finders.new_table({
              results = keybinds_data,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = string.format("%-20s │ %s", entry.key, entry.desc),
                  ordinal = entry.key .. " " .. entry.desc,
                }
              end,
            }),

            sorter = conf.generic_sorter({}),

            -- ================================================================
            -- PANEL PRATINJAU (PREVIEW) UNTUK DESKRIPSI PANJANG
            -- ================================================================
            previewer = previewers.new_buffer_previewer({
              title = "Detail Penjelasan",
              define_preview = function(self, entry)
                local lines = {
                  "┌─────────────────────────────────────────┐",
                  "│  KEYBINDING                             │",
                  "└─────────────────────────────────────────┘",
                  "",
                  "  Tombol     :  " .. entry.value.key,
                  "",
                  "┌─────────────────────────────────────────┐",
                  "│  PENJELASAN                             │",
                  "└─────────────────────────────────────────┘",
                  "",
                  "  " .. entry.value.desc,
                  "",
                }

                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

                local win = self.state.winid
                if win and vim.api.nvim_win_is_valid(win) then
                  vim.wo[win].wrap = true
                  vim.wo[win].linebreak = true
                  vim.wo[win].breakindent = true
                end
              end,
            }),

            -- ================================================================
            -- MENONAKTIFKAN ENTER (HANYA MENUTUP POPUP)
            -- ================================================================
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
              end)
              return true
            end,

            -- ================================================================
            -- PENGATURAN TAMPILAN RESPONSIF
            -- ================================================================
            layout_strategy = "flex",

            layout_config = {
              width = 0.95,
              height = 0.9,
              flip_columns = 120,

              horizontal = {
                preview_width = 0.5,
                preview_cutoff = 0,
              },

              vertical = {
                preview_height = 0.4,
                preview_cutoff = 0,
              },
            },
          })
          :find()
      end,
      desc = "Kamus Keybinding (Bahasa Indonesia)",
    },
  },
}
