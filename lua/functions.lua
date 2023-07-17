local function new_note(args)

    local luasnip = require("luasnip")
    -- Get the current UTC time
    local timestamp = os.date("!%m%d%Y%H%M%S")

    vim.cmd.edit(timestamp .. "-" .. table.concat(args.fargs, "-") .. ".md")

    -- Get "zettel" snippet and expand it in current buffer
    for _, snippet in pairs(luasnip.get_snippets("pandoc")) do
        if snippet.name == "zettel" then
            luasnip.snip_expand(snippet, {})
            return
        end
    end
end

vim.api.nvim_create_user_command("NewNote", function(...)
    new_note(...)
end, {
    nargs = "*",
})

