local gpt = require("gp")
gpt.setup({
    log_level = "debug",
    providers = {
        openai = {
            api_key = os.getenv("OPENAI_API_KEY"),
        },
    },

    agents = {
		{
			name = "GPT52",
            provider = "openai",
            model = "gpt-5.2",
			disable = false,
            chat = true,
			command = true,
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = require("gp.defaults").chat_system_prompt,
		},
        
	},
    default_agent = "GPT52",
})

vim.keymap.set("n", "<leader>gc", function()
  vim.cmd([[GpRewrite Add concise Doxygen-style comments. Explain parameters, units, assumptions, and safety considerations. Do not restate obvious code.]])
end, { desc = "Generate documentation" })
