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

local function visual_line_range()
  -- start of visual selection
  local vpos = vim.fn.getpos("v")
  local vline = vpos[2]

  -- current cursor position (end of selection)
  local cpos = vim.fn.getpos(".")
  local cline = cpos[2]

  local sline = math.min(vline, cline)
  local eline = math.max(vline, cline)
  return sline, eline
end

local function gp_comment_prompt()
    local ft = vim.bo.filetype

    if ft == "python" then
        return table.concat({
            "Add pythonic documentation:",
            " Use Google-style docstrings (triple quotes) for functions/classes.",
            " Add minimal inline comments only where intent is not obvious",
            " Document parameters, types and a snippet about them",
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

    local sline, eline = visual_line_range()

    -- leave visual mode so gp can safely edit
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)

    vim.cmd(string.format("%d,%dGpRewrite %s", sline, eline, prompt))
end, { desc = "Generate documentation" })

vim.keymap.set("n", "<leader>gc", function()
    local prompt = gp_comment_prompt()
    vim.cmd(string.format("GpRewrite %s", prompt))
end, { desc = "Generate documentation" })
