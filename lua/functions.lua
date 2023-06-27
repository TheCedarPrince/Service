function NewNote(...)
  local args = {...}
  local luasnip = require("luasnip")

  -- Get the current UTC time
  local timestamp = os.date("!%m%d%Y%H%M%S")

  -- Create the filename based on the timestamp and arguments
  local filename = timestamp .. "-" .. table.concat(args, "-") .. ".md"

  -- Create the new file
  local file = io.open(filename, "w")
  file:close()

  -- Open the file in a new buffer
  vim.cmd("edit " .. filename)

  -- Get "zettel" snippet and expand it in current buffer
  for _, snippet in pairs(luasnip.get_snippets("pandoc")) do
			if snippet.name == "zettel" then
				luasnip.snip_expand(snippet, {})
				return
			end
		end
end

-- Creates a new note within the current directory
vim.cmd("command! -nargs=* NewNote lua NewNote(<f-args>)")
