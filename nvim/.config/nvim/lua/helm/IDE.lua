require("Comment").setup {}

require("nvim-surround").setup {}

-- require("nvim-surround").buffer_setup {
--   surrounds = {
--     ["l"] = {
--       add = function()
--         local clipboard = vim.fn.getreg("+"):gsub("^[%s\n]*(.-)[%s\n]*$", "%1")
--         if clipboard:find("\n") then
--           vim.notify("URL must not contain newline characters", vim.log.levels.WARN)
--         else
--           return {
--             { "[" },
--             { "](" .. clipboard .. ")" },
--           }
--         end
--       end,
--       find = "%b[]%b()",
--       delete = "^(%[)().-(%]%b())()$",
--       change = {
--         target = "^()()%b[]%((.-)()%)$",
--         replacement = function()
--           local clipboard = vim.fn.getreg("*"):gsub("^[%s\n]*(.-)[%s\n]*$", "%1")
--           if clipboard:find("\n") then
--             vim.notify("URL must not contain newline characters", vim.log.levels.WARN)
--           else
--             return {
--               { "" },
--               { clipboard },
--             }
--           end
--         end,
--       },
--     },
--   },
-- }
