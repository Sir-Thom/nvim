vim.g.mapleader = ","
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>rn", function()
    local old_name = vim.fn.expand('%')  -- Get the current file name
    local new_name = vim.fn.input('New name: ', old_name)
    if new_name ~= '' and new_name ~= old_name then
        vim.cmd('saveas ' .. new_name)  -- Save the current file as the new name
        vim.cmd('bdelete ' .. old_name)  -- Delete the old buffer
    end
end, { desc = "Rename the current file" })

vim.keymap.set("n", "<leader>nf", function()
    local file_path = vim.fn.input('File path: ', vim.fn.expand('%:p:h'))  -- Default to current directory of the open file
    if file_path ~= '' then
        vim.cmd('edit ' .. file_path)  -- Open the new file or directory
    end
end, { desc = "Create or open a file with a specified path" })


vim.keymap.set("n", "<leader>df", function()
    local file_to_delete = vim.fn.input('Delete file: ')
    if file_to_delete ~= '' then
        if vim.fn.filereadable(file_to_delete) == 1 then
            os.remove(file_to_delete)  -- Remove the file
            vim.cmd('bdelete')         -- Delete the buffer if it's open
        else
            print("File does not exist: " .. file_to_delete)
        end
    end
end, { desc = "Delete a file" })


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ps',function()
builtin.grep_string({ search = vim.fn.input("Grep > ")});
overrides = function(colors)
    local theme = colors.theme
    return {
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
    }
end
end)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('i', '<F5>', '<Plug>(completion_trigger)', opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)

        -- Set up diagnostic mappings
        vim.keymap.set('n', '<space>e', function() vim.cmd("lua vim.diagnostic.open_float()") end, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    end,
})

local keys = {
    {
        "<leader>db",
        function() require("dap").list_breakpoints() end,
        desc = "DAP Breakpoints",
    },
    {
        "<leader>ds",
        function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes, { border = "rounded" })
        end,
        desc = "DAP Scopes",
    },
    { "<F1>", function() require("dap.ui.widgets").hover(nil, { border = "rounded" }) end },
    { "<F4>", "<CMD>DapDisconnect<CR>", desc = "DAP Disconnect" },
    { "<F16>", "<CMD>DapTerminate<CR>", desc = "DAP Terminate" },
    { "<F5>", "<CMD>DapContinue<CR>", desc = "DAP Continue" },
    { "<F17>", function() require("dap").run_last() end, desc = "Run Last" },
    { "<F6>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<F9>", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
    {
        "<F21>",
        function()
            vim.ui.input(
                { prompt = "Breakpoint condition: " },
                function(input) require("dap").set_breakpoint(input) end
            )
        end,
        desc = "Conditional Breakpoint",
    },
    { "<F10>", "<CMD>DapStepOver<CR>", desc = "Step Over" },
    { "<F11>", "<CMD>DapStepInto<CR>", desc = "Step Into" },
    { "<F12>", "<CMD>DapStepOut<CR>", desc = "Step Out" },
}


