local dap = require("dap")       -- Load DAP
local dapui = require("dapui")   -- Load DAP UI

-- DAP UI setup
dapui.setup()

-- DAP listeners to manage UI
dap.listeners.before.attach["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.launch["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Key mappings for DAP
vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

