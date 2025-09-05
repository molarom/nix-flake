-- File Tree explorer with all the bells and whistles.
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"miversen33/netman.nvim",
		},
		keys = {
			-- suggested keymap
			{ "<leader>n", "<cmd>Neotree<cr>", desc = "Open [N]eotree" },
		},
		opts = {
			close_if_last_window = false,
			auto_clean_after_session_restore = true,
			window = {
				mappings = {
					["o"] = "system_open",
					["T"] = "trash",
				},
			},
			commands = {
				trash = function(state)
					local node = state.tree:get_node()
					if node.type == "message" then
						return
					end
					local _, name = require("neo-tree.utils").split_path(node.path)
					local msg = string.format("Are you sure you want to trash '%s'?", name)
					require("neo-tree.ui.inputs").confirm(msg, function(confirmed)
						if not confirmed then
							return
						end
						vim.api.nvim_command("silent !trash -F " .. node.path)
						require("neo-tree.sources.manager").refresh(state)
					end)
				end,
				trash_visual = function(state, selected_nodes)
					local paths_to_trash = {}
					for _, node in ipairs(selected_nodes) do
						if node.type ~= "message" then
							table.insert(paths_to_trash, node.path)
						end
					end
					local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
					require("neo-tree.ui.inputs").confirm(msg, function(confirmed)
						if not confirmed then
							return
						end
						for _, path in ipairs(paths_to_trash) do
							vim.api.nvim_command("silent !trash -F " .. path)
						end
						require("neo-tree.sources.manager").refresh(state)
					end)
				end,
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()

					if vim.loop.os_uname().sysname == "Darwin" then
						vim.fn.jobstart({ "open", path }, { detach = true })
					else
						vim.fn.jobstart({ "xdg-open", path }, { detach = true })
					end
				end,
			},
			filesystem = {
				use_libuv_file_watcher = true,
			},
			event_handlers = {
				{
					event = "neo_tree_window_before_open",
					handler = function(args)
						print("neo_tree_window_before_open", vim.inspect(args))
					end,
				},
				{
					event = "neo_tree_window_after_open",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},
				{
					event = "neo_tree_window_before_close",
					handler = function(args)
						print("neo_tree_window_before_close", vim.inspect(args))
					end,
				},
				{
					event = "neo_tree_window_after_close",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},
			},
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
				"netman.ui.neo-tree",
			},
			source_selector = {
				winbar = true,
				sources = {
					{ source = "filesystem" },
					{ source = "buffers" },
					{ source = "git_status" },
					{ source = "document_symbols" },
					{ source = "remote" },
				},
			},
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal", "quickfix" },
					},
				},
			})
		end,
	},
}
