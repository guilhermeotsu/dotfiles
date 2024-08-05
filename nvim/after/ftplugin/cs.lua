vim.opt.shiftwidth = 4

vim.cmd[[
  function! AutoBracketDrop()
    if col('.') == col('$') - 1
      substitute /\s*$//
      exec "normal! A\<Cr>{\<Cr>X\<Cr>}\<Esc>k$x"
    else
      exec "normal! a{\<Cr>\<Esc>"
    endif
  endfunction
]]

vim.keymap.set('i', '{<cr>', '<Esc>:call AutoBracketDrop()<cr>')
