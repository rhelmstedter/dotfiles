require("luasnip.loaders.from_vscode").load()

local ls = require("luasnip")
-- local types = require("luasnip.util.type")

ls.config.set_config({
	history = true,
	updateevents = "TextChanged, TextChangedI",
	enable_autosnippets = true,
})

-- vim.keymap.set({"i", "s"}, "<c-f>", function()
--     if ls.expand_or_jumpable() then
--         ls.exand_orjump()
--     end
-- end, {silent = true})
