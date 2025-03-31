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
            f(function() return vim.fn.expand("%:t") end),
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
        s("rarrow", { t("──›") }),
        s("larrow", { t("‹──") }),
        s("uarrow", { t({ "∧", "│" }) }),
        s("darrow", { t({ "│", "∨" }) }),
        s("dlarrow", { t({ "  │", "‹─╯" }) }),
        s("drarrow", { t({ "│ ", "╰─›" }) }),
        s("ularrow", { t({ "‹─╮", "  │" }) }),
        s("urarrow", { t({ "╭─›", "│ " }) }),
    })
