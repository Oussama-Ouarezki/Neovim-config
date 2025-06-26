return {
	{
		"g0t4/iron.nvim",
		branch = "fix-clear-repl",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local iron = require("iron.core")
			local ll = require("iron.lowlevel")
			local map = vim.keymap.set

			local function get_or_open_repl()
				local meta = vim.b.repl
				if not meta or not ll.repl_exists(meta) then
					local ft = ll.get_buffer_ft(0)
					meta = ll.get(ft)
				end
				if not ll.repl_exists(meta) then
					return nil
				end
				return meta
			end

			local function toggle_repl()
				local meta = vim.b.repl
				if meta and ll.repl_exists(meta) then
					iron.hide_repl()
				else
					iron.repl_for(vim.api.nvim_buf_get_option(0, "filetype"))
				end
			end

			local function my_clear()
				iron.clear_repl()
				get_or_open_repl()
			end

			local function send_visual_and_jump()
				iron.visual_send()
				vim.schedule(function()
					-- Exit visual mode
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true),
						'n', true)
					-- Jump to next line
					vim.cmd("normal! j")
				end)
			end

			map("n", "<space>rr", iron.repl_restart, { desc = "Restart REPL" })
			map("n", "<space>rx", my_clear, { desc = "Clear REPL" })
			map("n", "<space>rh", toggle_repl, { desc = "Toggle REPL" })
			map("v", "<space>rl", send_visual_and_jump, { desc = "Send visual selection" })
			map("n", "<space>rf", iron.send_file, { desc = "Send file" })
			map("n", "<space>rl", function()
				iron.send_line()
				vim.schedule(function()
					vim.cmd("normal! j")
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true),
						'n', true)
				end)
			end, { desc = "Send line and jump" })
			map("n", "<space>rp", function()
				iron.send_paragraph()
				vim.schedule(function()
					vim.cmd("normal! }")
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true),
						'n', true)
				end)
			end, { desc = "Send paragraph and jump" })
			map("n", "<space>rc", function()
				iron.send_code_block()
				vim.schedule(function()
					vim.cmd("normal! ]}")
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true),
						'n', true)
				end)
			end, { desc = "Send code block and jump" })

			iron.setup({
				config = {
					scratch_repl = true,
					repl_open_cmd = "vertical botright split",
					repl_definition = {
						_DEFAULT = {
							command = { "bash" },
						},
						sh = {
							command = { "fish" },
						},
						lua = {
							command = { "lua" },
							block_deviders = { "-- %%", "--%%" },
						},
						python = {
							command = { "/home/oussama/miniconda3/envs/manimenv/bin/ipython", "--no-autoindent" },
							format = function(lines, extras)
								local result = require("iron.fts.common")
								    .bracketed_paste_python(lines, extras)
								return vim.tbl_filter(function(line)
									return not string.match(line, "^%s*#")
								end, result)
							end,
						},
					},
				},
			})
		end,
	},
}
