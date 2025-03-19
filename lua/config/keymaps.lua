vim.keymap.set("n", "J", "gj") -- J moves down visually

-- Remap q: to <NOP> to disable the command history buffer
vim.api.nvim_set_keymap("n", "q:", "<NOP>", { noremap = true, silent = true })

-- Remap < y > para mantener el modo visual
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

local function search_and_replace(is_whole_word, is_visual)
	local search = vim.fn.input("Palabra a buscar: ")
	local replace = vim.fn.input("Reemplazar con: ")

	if search == "" or replace == "" then
		print("Operación cancelada: ambas palabras deben ser proporcionadas.")
		return
	end

	search = vim.fn.escape(search, "/\\[]^$.*")
	replace = vim.fn.escape(replace, "/\\")

	-- Si es búsqueda de palabra completa, agregamos \< y \>
	if is_whole_word then
		search = string.format("\\<%s\\>", search)
	end

	local range = is_visual and "'<,'>" or "%"

	vim.api.nvim_command(string.format("%ss/%s/%s/g", range, search, replace))
end

vim.keymap.set("n", "<leader>sr", function()
	search_and_replace(false, false)
end, { desc = "Buscar y reemplazar" })
vim.keymap.set("n", "<leader>sw", function()
	search_and_replace(true, false)
end, { desc = "Buscar y reemplazar palabra completa" })
vim.keymap.set("v", "<leader>sr", function()
	search_and_replace(false, true)
end, { desc = "Buscar y reemplazar en selección" })
vim.keymap.set("v", "<leader>sw", function()
	search_and_replace(true, true)
end, { desc = "Buscar y reemplazar palabra completa en selección" })
