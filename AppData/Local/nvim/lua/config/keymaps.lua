-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local keymap = vim.keymap
local keymap = vim.keymap

-- note: [[ delete/unset/disable lazyvim defaults ]]

keymap.del({ "n", "x" }, "j")
keymap.del({ "n", "x" }, "<Down>")
keymap.del({ "n", "x" }, "k")
keymap.del({ "n", "x" }, "<Up>")
keymap.del({ "n", "i", "v" }, "<a-j>")
keymap.del({ "n", "i", "v" }, "<A-k>")
keymap.del("n", "<leader>l") -- :Lazy
keymap.del("n", "<leader>`") -- Open other Buffer
keymap.del("n", "<leader>qq") -- :qa
keymap.del("n", "<leader>bd") -- Buf Quit
keymap.del("n", "<leader>ub") -- Toggle Background
keymap.del("n", "<leader>ul") -- Toggle Line Numbers
keymap.del("n", "<leader>uL") -- Toggle Relative Line Numbers

-- NOTE: [[ KEYMAPS/REMAPS ]]

-- remapping : and ;
keymap.set({ "n", "v" }, ";", ":", { noremap = true })
keymap.set({ "n", "v" }, ":", ";", { noremap = true })
keymap.set({ "n", "x" }, "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
keymap.set("n", "U", "<C-r>")
keymap.set("n", "<leader>q", LazyVim.ui.bufremove, { desc = "Delete Buf" })
keymap.set({ "n", "x" }, "x", '"_x')

-- Yank/Delete/Paste
-- -- map({ "n", "x" }, "<leader>d", [["_d]])
-- -- set({ 'n', 'v' }, '<leader>D', [["_D]], { desc = '[D] into Void' }) -- Existing keymap LSP: Type Def
-- keymap.set("x", "<leader>P", [["_dP]])
-- keymap.set({ "x" }, "<leader>y", [["+y]])
-- keymap.set({ "n", "x" }, "<leader>Y", [["+y$]])
-- keymap.set("n", "<leader>yy", [["+yy]])
-- keymap.set({ "n", "x" }, "<leader>p", [["+p]])

-- yank current filepath
keymap.set(
  "n",
  "<leader>yf",
  ':let @+ = expand("%:p")<cr>:lua print("Yanked filepath to system clipboard: " .. vim.fn.expand("%:p"))<cr>',
  { desc = "[Y]ank [F]ilepath", silent = true }
)
-- yank parent dir path
keymap.set("n", "<leader>yd", function()
  local fullpath = vim.api.nvim_buf_get_name(0)
  if fullpath == "" then
    return
  end
  local dir = vim.fn.fnamemodify(fullpath, ":p:h")
  dir = vim.fn.fnamemodify(dir, ":p:h")
  vim.fn.setreg("+", dir)
  print("Yanked parent path to system clipboard: " .. dir)
end, { desc = "[Y]ank [D]ir Path" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line Down", silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line Up", silent = true })
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
-- keymap.set("n", "{", "{zz")
-- keymap.set("n", "}", "}zz")
-- map("n", "N", "Nzzzv")
-- map("n", "n", "nzzzv")

-- Logging
keymap.set("n", "<leader>lp", ":lua vim.print(<C-R>+)", { desc = "[P]aste (+ reg)" })
-- map('n', '<leader>lg', ":lua for k, v in pairs(vim.api.nvim_exec('let g:', true) do vim.print(k, v) end", { desc = '[G]lobals' })
keymap.set("n", "<leader>lP", ':lua vim.print(<C-R>")', { desc = '[P]aste (" reg)' })
keymap.set("n", "<leader>li", ":lua vim.print()<LEFT>", { desc = "[I]nspect" })
keymap.set("n", "<leader>lr", ':lua vim.print(require(""))<LEFT><LEFT><LEFT>', { desc = "[R]equire" })
keymap.set("n", "<leader>ls", function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(
      ":lua vim.print(vim.fn.has_key(,'key'))" .. string.rep("<LEFT>", 8),
      true,
      false,
      true
    ),
    "n",
    false
  )
end, { desc = "[S]earch Obj (Table)" })
keymap.set("n", "<leader>le", ":lua vim.print(vim.env.)<LEFT>", { desc = "[E]nvs" })

-- -- Move panes in terminal mode for  NOTE: toggleterm.nvim
-- map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = 'Switch to Left Pane' })
-- map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = 'Switch to Lower Pane' })
-- map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = 'Switch to Upper Pane' })
-- map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = 'Switch to Right Pane' })

keymap.set("n", "Q", "<nop>")
keymap.set({ "i", "c", "t", "v" }, "<F13>", "<nop>")
