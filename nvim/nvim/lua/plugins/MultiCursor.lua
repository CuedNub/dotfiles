return {
  "mg979/vim-visual-multi",
  lazy = false,
  priority = 1000,
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_mouse_mappings = 1

    -- Menggunakan tombol yang aman dari jebakan Terminal
    vim.g.VM_maps = {
      ["Add Cursor At Pos"] = "<M-c>", -- Alt + c untuk taruh kursor (Aman)
      ["Find Under"] = "<C-n>", -- Ctrl + n untuk pilih kata
    }
  end,
}
