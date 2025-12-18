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

local function gp_comment_prompt()
    local ft = vim.bo.filetype

    if ft == "python" then
        return table.concat({
            "Add pythonic documentation:",
            " Use Google-style docstrings (triple quotes) for functions/classes.",
            " Add minimal inline comments only where intent is not obvious",
            " Do not change the code.",
        }, " ")
    elseif ft == "cpp" or ft == "c" then
        return table.concat({
            " Add concise Doxygen-style comments:",
            " Use /** */ for doc blocks and // for inline comments.",
            " Document parameters, units, ownership, and invariants.",
            " Do not restate obvious code.",
        }, " ")
    else
        return "Add concise comments appropriate for this language and its conventions."
    end
end

vim.keymap.set("v", "<leader>gc", function()
    local prompt = gp_comment_prompt()
    vim.cmd(string.format("'<,'>GpRewrite %s", prompt))
end, { desc = "Generate documentation" })

vim.keymap.set("n", "<leader>gc", function()
    local prompt = gp_comment_prompt()
    vim.cmd(string.format("GpRewrite %s", prompt))
end, { desc = "Generate documentation" })
