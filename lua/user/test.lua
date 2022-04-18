local status_ok, ultest = pcall(require, "ultest")

if not status_ok then
  vim.notify("ultest was not loaded ")
  return
end


vim.cmd([[let test#javascript#reactscripts#options = "--watchAll=false"]])
vim.cmd([[let test#javascriptreact#reactscripts#options = "--watchAll=false"]])
vim.cmd([[let test#typescript#reactscripts#options = "--watchAll=false"]])
vim.cmd([[let test#typescriptreact#reactscripts#options = "--watchAll=false"]])
vim.cmd(
  [[
augroup UltestRunner
    au!
    au BufWritePost *.test.* UltestNearest
    au BufWritePost *.spec.* UltestNearest
augroup END
]]
)
vim.g.ultest_virtual_text = 1
vim.g.ultest_output_on_run = 0
vim.g.ultest_pass_text = ""
vim.g.ultest_fail_text = "💥"
vim.g.ultest_running_text = "⌛"


vim.api.nvim_exec(
				[[
                hi UltestPass ctermfg=Green guifg=#96F291
                hi UltestFail ctermfg=Red guifg=#F70067
                hi UltestRunning ctermfg=Yellow guifg=#FFEC63
                hi UltestBorder ctermfg=Red guifg=#F70067
                hi UltestSummaryInfo ctermfg=cyan guifg=#00F1F5 gui=bold cterm=bold
                hi link UltestSummaryFile UltestSummaryInfo
                hi link UltestSummaryNamespace UltestSummaryInfo
              ]], false)

