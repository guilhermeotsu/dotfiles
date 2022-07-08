local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end
  
map('i', 'jj', '<Esc><CR>')
map('n', '<leader>w', ':w<CR>')

map('x' , 'aa', function() require'align'.align_to_char(1, true)             end) 
map('x' , 'as', function() require'align'.align_to_char(2, true, true)       end) 
map('x' , 'aw', function() require'align'.align_to_string(false, true, true) end) 
map('x' , 'ar', function() require'align'.align_to_string(true, true, true)  end) 
