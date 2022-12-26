require("xbase").setup({
	sourcekit = {
		on_attach = function(_, bufnr)
			local opts = { noremap = true, silent = false, buffer = bufnr }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "<leader>lf", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
			vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
			vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)
		end,
	},
  mappings = {
    --- Whether xbase mapping should be disabled.
    enable = true,
    --- Open build picker. showing targets and configuration.
    build_picker = "<leader>ab", --- set to 0 to disable
    --- Open run picker. showing targets, devices and configuration
    run_picker = "<leader>ar", --- set to 0 to disable
    --- Open watch picker. showing run or build, targets, devices and configuration
    watch_picker = "<leader>as", --- set to 0 to disable
    --- A list of all the previous pickers
    all_picker = "<leader>af", --- set to 0 to disable
    --- horizontal toggle log buffer
    toggle_split_log_buffer = "<leader>als",
    --- vertical toggle log buffer
    toggle_vsplit_log_buffer = "<leader>alv",
  },
})
