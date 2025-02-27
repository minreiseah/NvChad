-- normal commands
vim.wo.scrolloff = 10
vim.wo.foldmethod = "indent"
vim.wo.foldenable = false
vim.wo.linebreak = true
vim.api.nvim_set_keymap('n', 's', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-i>', { noremap = true, silent = true })

-- special commands

local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- runs command in nvim terminal to the side (vertical)
function TermWrapper(command)
  vim.cmd('write')
  local buffercmd = 'vnew'
  vim.cmd(buffercmd)
  vim.cmd('term ' .. command)
  vim.cmd('setlocal nornu nonu')
  vim.cmd('startinsert')
  vim.cmd('autocmd BufEnter <buffer> startinsert')
end

vim.cmd("command! -nargs=0 CompileAndRunC lua TermWrapper(string.format('gcc -g -o %s %s && ./%s', vim.fn.expand('%:r'), vim.fn.expand('%'), vim.fn.expand('%:r')))")
vim.cmd("command! -nargs=0 CompileAndRunCPPFast lua TermWrapper(string.format('g++ -std=c++17 %s -O2 -Wno-unused-result && ./a.out', vim.fn.expand('%')))")
vim.cmd("command! -nargs=0 CompileAndRunCPPSafe lua TermWrapper(string.format('g++ -std=c++17 -Wshadow -Wall %s -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && ./a.out', vim.fn.expand('%')))")
vim.cmd("command! -nargs=0 CompileAndRunPython lua TermWrapper(string.format('python3 %s', vim.fn.expand('%')))")
vim.cmd("command! -nargs=0 CompileAndRunJavascriptNode lua TermWrapper(string.format('node %s', vim.fn.expand('%')))")
vim.cmd("command! -nargs=0 CompileAndRunJava lua TermWrapper(string.format('javac %s && java -cp . %s', vim.fn.expand('%'), vim.fn.expand('%:r')))")

vim.cmd("autocmd FileType c nnoremap <F8> :CompileAndRunC<CR>")
vim.cmd("autocmd FileType cpp nnoremap <F8> :CompileAndRunCPPFast<CR>")
vim.cmd("autocmd FileType cpp nnoremap <F9> :CompileAndRunCPPSafe<CR>")
vim.cmd("autocmd FileType python nnoremap <F8> :CompileAndRunPython<CR>")
vim.cmd("autocmd FileType javascript nnoremap <F8> :CompileAndRunJavascriptNode<CR>")
vim.cmd("autocmd FileType java nnoremap <F8> :CompileAndRunJava<CR>")

-- enable providers
local enable_providers = {
  "python3_provider",
  "node_provider",
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

-- disable virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
})

-- show only modified buffers
vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
  callback = function()
    vim.t.bufs = vim.tbl_filter(function(bufnr)
      return vim.api.nvim_buf_get_option(bufnr, "modified")
    end, vim.t.bufs)
  end,
})

-- custom settings per filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
  end,
})
