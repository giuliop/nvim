-- Rust language plugin configuration
return {
  "rust-lang/rust.vim",
  ft = "rust",
  config = function()
    -- Enable RustFmt on save (equivalent to let g:rustfmt_autosave = 1)
    vim.g.rustfmt_autosave = 1
  end,
}