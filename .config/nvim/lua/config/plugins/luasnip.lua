return {
    {
        'L3MON4D3/LuaSnip',
        config = function()
            local ls = require("luasnip")
            local s = ls.snippet
            local t = ls.text_node
            local i = ls.insert_node
            local f = ls.function_node

            ls.add_snippets(
                "all", {
                    s("(", { t("( "), i(1), t(" )") }),
                    s("{", { t("{ "), i(1), t(" }") }),
                    s("[", { t("[ "), i(1), t(" ]") }),
                    s("<", { t("< "), i(1), t(" >") }),
                    s("`", { t("`"), i(1), t("`") }),
                    s("'", { t("'"), i(1), t("'") }),
                    s('"', { t('"'), i(1), t('"') }),

                    s("datef", f(function()
                        return vim.fn.system("date '+%A, %d de %B de %Y' | sed -E 's/^(.)/\\U\\1/'"):gsub("\n", "")
                    end))
                })

            ls.add_snippets(
                "markdown", {
                    s({ trig = "bb", desc = "Make text bold" }, { t('**'), i(1), t('**') }),
                    s({ trig = "cb|codeblock", desc = "Insert markdown codeblock" }, {
                        t("```"),
                        i(1),
                        t({ "", "" }),
                        i(2),
                        t({ "", "```" })
                    }),
                    s({ trig = "nn|newnote", desc = "New note template (Obsidian)" }, {
                        t({ "", "Status: #baby", "Tags: " }),
                        i(1),
                        t({ "", "", "# " }),
                        f(function() return vim.fn.expand("%:t"):gsub("%.%w+$", "") end),
                        t({ "", "", "" }),
                        i(2),
                        t({ "", "", "---", "# Referências", "" }),
                    }),
                    s("box", {
                        f(function(args)
                            local text = args[1][1] or ""
                            local len = #text
                            return "╭" .. string.rep("─", len + 2) .. "╮"
                        end, { 1 }),
                        t({ "", "│ " }), i(1, "Escreva aqui"), t({ " │", "" }),
                        f(function(args)
                            local text = args[1][1] or ""
                            local len = #text
                            return "╰" .. string.rep("─", len + 2) .. "╯"
                        end, { 1 })
                    }),
                    s({ trig = "rarrow|arrowr", desc = "Right arrow" }, { t("──›"), i(1) }),
                    s({ trig = "larrow|arrowl", desc = "Left arrow" }, { i(1), t(" ‹──") }),
                    s({ trig = "uarrow|arrowu", desc = "Up arrow" }, { i(1), t({ "", "∧", "│" }) }),
                    s({ trig = "darrow|arrowd", desc = "Down arrow" }, { t({ "│", "∨", "" }), i(1) }),
                    s({ trig = "dlarrow|arrowdl", desc = "Down left arrow" }, { t({ "  │", "‹─╯" }) }),
                    s({ trig = "drarrow|arrowdr", desc = "Down right arrow" }, { t({ "│ ", "╰─›" }) }),
                    s({ trig = "ularrow|arrowul", desc = "Up left arrow" }, { t({ "‹─╮", "  │" }) }),
                    s({ trig = "urarrow|arrowur", desc = "Up right arrow" }, { t({ "╭─›", "│ " }) }),
                    s({ trig = "luarrow|arrowlu", desc = "Left up arrow" }, { t({ "∧", "╰─" }) }),
                    s({ trig = "ldarrow|arrowld", desc = "Left down arrow" }, { t({ "╭─", "∨" }) }),
                    s({ trig = "ruarrow|arrowru", desc = "Right up arrow" }, { t({ " ∧", "─╯" }) }),
                    s({ trig = "rdarrow|arrowrd", desc = "Right down arrow" }, { t({ "─╮", " ∨" }) }),


                    s("matrix", {
                        f(function(args)
                            local text = args[1][1] or ""
                            local len = #text
                            return "┌" .. string.rep(" ", len + 2) .. "┐"
                        end, { 1 }),
                        t({ "", "│ " }), i(1, "Escreva aqui"), t({ " │", "" }),
                        f(function(args)
                            local text = args[1][1] or ""
                            local len = #text
                            return "└" .. string.rep(" ", len + 2) .. "┘"
                        end, { 1 })
                    }),
                })
        end
    },
}
