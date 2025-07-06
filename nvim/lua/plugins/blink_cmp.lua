return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
    keymap = { preset = 'super-tab' },
    cmdline = { enabled = false },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    -- menu = { auto_show = false },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono'
    },
    sources = {
      default = { 'lsp', 'easy-dotnet', 'path', 'snippets', 'buffer' },
      providers = {
        ["easy-dotnet"] = {
          name = "easy-dotnet",
          enabled = true,
          module = "easy-dotnet.completion.blink",
          score_offset = 10000,
          async = true,
        },
      }
    },
  },
  opts_extend = { "sources.default" }
}
