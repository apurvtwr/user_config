local gp = require("gp")
local defaults = require("gp.defaults")

local function get_openai_api_key()
    local result = vim.system({
        "op",
        "read",
        "op://Personal/OpenAI_API_KEY/notesPlain",
    }, { text = true }):wait()

    if result.code ~= 0 then
        error("Failed to read OpenAI API key from 1Password:\n" .. result.stderr)
    end

    return vim.trim(result.stdout)
end
gp.setup({
  log_level = "debug",

  providers = {
    openai = {
      endpoint = "https://api.openai.com/v1/chat/completions",
      secret = get_openai_api_key(),
    },
  },

  agents = {
    {
      name = "GPT52",
      provider = "openai",
      model = { model = "gpt-5.2" },
      disable = false,
      chat = true,
      command = true,
      system_prompt = defaults.chat_system_prompt,
    },
  },

  default_chat_agent = "GPT52",
  default_command_agent = "GPT52",
})

local function visual_line_range()
  local vpos = vim.fn.getpos("v")
  local cpos = vim.fn.getpos(".")

  local vline = vpos[2]
  local cline = cpos[2]

  return math.min(vline, cline), math.max(vline, cline)
end

local function gp_comment_prompt()
  local ft = vim.bo.filetype

  if ft == "python" then
    return table.concat({
      "Add pythonic documentation.",
      "Use Google-style docstrings with triple quotes for functions and classes.",
      "Add minimal inline comments only where intent is not obvious.",
      "Document parameters, types, return values, exceptions, and key assumptions.",
      "Do not change the code.",
    }, " ")
  end

  if ft == "cpp" or ft == "c" or ft == "hpp" or ft == "h" then
    return table.concat({
      "Add concise Doxygen-style comments.",
      "Use /** */ for function, class, and struct doc blocks.",
      "Use // only for useful inline comments.",
      "Document parameters, units, ownership, invariants, preconditions, and return values.",
      "Do not restate obvious code.",
      "Do not change the code.",
    }, " ")
  end

  if ft == "java" then
    return table.concat({
      "Add concise Javadoc-style comments.",
      "Use /** */ for function, class, and interface doc blocks.",
      "Use // only for useful inline comments.",
      "Document parameters, units, ownership, invariants, preconditions, and return values.",
      "Do not restate obvious code.",
      "Do not change the code.",
    }, " ")
  end

  return table.concat({
    "Add concise comments appropriate for this language and its conventions.",
    "Document intent, parameters, return values, ownership, invariants, and important assumptions.",
    "Do not restate obvious code.",
    "Do not change the code.",
  }, " ")
end

local function gp_implement_function_prompt()
  local ft = vim.bo.filetype

  return table.concat({
    "Write the implementation for the selected function.",
    "",
    "Use the function signature, comments, and surrounding context.",
    "Preserve the existing function signature.",
    "Only replace the selected function body or stub.",
    "Add concise comments for this language and it's conventions.",
    "Document intent, parameters, return values ownership, invariants, and important assumptions",
    "",
    "Language/filetype: " .. ft,
  }, "\n")
end

local function escape_visual_mode()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
    "n",
    true
  )
end

vim.keymap.set("v", "<leader>gc", function()
  local prompt = gp_comment_prompt()
  local sline, eline = visual_line_range()

  escape_visual_mode()

  vim.cmd({
    cmd = "GpRewrite",
    range = { sline, eline },
    args = { prompt },
  })
end, {
  desc = "Generate documentation for selection",
})

vim.keymap.set("n", "<leader>gc", function()
  local prompt = gp_comment_prompt()

  vim.cmd({
    cmd = "GpRewrite",
    args = { prompt },
  })
end, {
  desc = "Generate documentation",
})


vim.keymap.set("v", "<leader>gi", function()
  local prompt = gp_implement_function_prompt()
  local sline, eline = visual_line_range()

  escape_visual_mode()

  vim.cmd({
    cmd = "GpRewrite",
    range = { sline, eline },
    args = { prompt },
  })
end, {
  desc = "Generate function implementation with GP",
})
