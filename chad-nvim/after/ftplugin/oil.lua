local map = vim.keymap.set
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <CR><ESC>", {
	buffer = true
})
map({ "n", "i", "v" }, "<C-o>", "o")
map({ "n" }, "a", "o", {
	buffer = true
})
