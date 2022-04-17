local status_ok, dap = pcall(require, "dap")
if not status_ok then
  vim.notify("dap was not loaded ")
  return
end

local status_ok_ui, dapui = pcall(require, "dapui")
if not status_ok_ui then
  vim.notify("dapui was not loaded ")
  return
end

local job = require('plenary.job')

local fn = vim.fn
local notify = vim.notify

local dap_path = fn.stdpath('data')..'/dap'
local python_path = dap_path..'/python'

local function setup_python_adapter()
    dap.adapters.python = {
        type = 'executable',
        command = python_path..'/virtualenv/bin/python',
        args = { '-m', 'debugpy.adapter' }
    }
end

if dap.adapters['python'] == nil then
    -- Setting up dap for python
    if fn.empty(fn.glob(dap_path)) > 0 then
        fn.system({'mkdir', '-p', dap_path})
    end
    if fn.empty(fn.glob(python_path)) > 0 then
        fn.system({'mkdir', '-p', python_path})
    end
    if fn.empty(fn.glob(python_path..'/virtualenv')) > 0 then
        notify("Installing Python DAP...", vim.log.levels.INFO)
        job:new({
            command = '/usr/bin/python3',
            args = {'-m', 'virtualenv', 'virtualenv'},
            cwd = python_path,
        }):sync()
        job:new({
            command = python_path..'/virtualenv/bin/pip',
            args = {'install', 'debugpy'},
            cwd = python_path,
            on_exit = setup_python_adapter
        }):start()
    else
        setup_python_adapter()
    end
end

dap.configurations.python = {
    {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = "Launch awesome crawler",
    module = "awesome_crawler",
    pythonPath = function()
      return vim.env.VIRTUAL_ENV .. "/bin/python"
    end,
    },
    {
    type = 'python',
    request = 'launch',
    name = "Launch file",

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      return vim.env.VIRTUAL_ENV .. "/bin/python"
    end,
    },
}


vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})



dapui.setup({
  -- icons = { expanded = "?", collapsed = "?" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      { id = "scopes", size = 0.25 },
      { id = "breakpoints", size = 0.20 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 0.30 },
    },
    size = 50,  -- Width
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

-- automatically open dapui when start debugging
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
