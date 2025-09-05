-- Cursor like integration for Neovim.
--
-- Disabled until the project becomes more mature.
return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	enabled = false,
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		instructions_file = "avante.md",
		-- for example
		provider = "claude-code",
		providers = {
			-- claude = {
			--   endpoint = "https://api.anthropic.com",
			--   model = "claude-sonnet-4-20250514",
			--   timeout = 30000, -- Timeout in milliseconds
			--     extra_request_body = {
			--       temperature = 0.75,
			--       max_tokens = 20480,
			--   },
			-- },
			ollama = {
				endpoint = "http://localhost:11434",
				model = "llama3.2:3b",
			},
		},
		acp_providers = {
			["claude-code"] = {
				command = "npx",
				args = { "@zed-industries/claude-code-acp" },
				env = {
					NODE_NO_WARNINGS = "1",
				},
			},
		},
		rag_service = {
			enabled = true,
			runner = "nix",
			llm = { -- Configuration for the Language Model (LLM) used by the RAG service
				provider = "ollama", -- The LLM provider ("ollama")
				endpoint = "http://localhost:11434", -- The LLM API endpoint for Ollama
				api_key = "", -- Ollama typically does not require an API key
				model = "llama3.2:3b", -- The LLM model name (e.g., "llama2", "mistral")
				extra = nil, -- Extra configuration options for the LLM (optional) Kristin", -- Extra configuration options for the LLM (optional)
			},
			embed = { -- Configuration for the Embedding Model used by the RAG service
				provider = "ollama", -- The Embedding provider ("ollama")
				endpoint = "http://localhost:11434", -- The Embedding API endpoint for Ollama
				api_key = "", -- Ollama typically does not require an API key
				model = "nomic-embed-text", -- The Embedding model name (e.g., "nomic-embed-text")
				extra = { -- Extra configuration options for the Embedding model (optional)
					embed_batch_size = 10,
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-tree/nvim-web-devicons",
	},
}
