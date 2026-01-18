--
-- Einstellungsdatei fuer den Neovim Editor
-- Orginaldatei auf hera:~mario/.config/nvim/init.lua
--
-- Changelog
-- V2, 16.02.2026 Initial erstellt
--
-- V3, 17.02.2026 Colorscheme auf vim
--
-- Version 3, 17.01.2026  

-- Darstellungsoptionen
-- syntax on           " Syntax Highlighting aktiveren
-- set number          " Line Numbers anzeigen
-- set relativenumber  " Relative Nummerierung anzeigen
-- set linebreak       " Ganze Wörter in neue Zeile umbrechen
-- set showmode        " Aktuellen Modus in Statuszeile anzeigen
-- set scrolloff=5     " Cursor bei Scroll weiter oben halten
-- set mouse=a         " Scrollen mit der Mouse in Console und tmux
-- set lazyredraw      " Weniger Redraws bei Macros und co.
-- set cursorline      " Aktive Zeile markieren
-- set updatetime=300  " Schellere Darstellung	/ Refresh
-- set cc=80           " Markierung 80 Zeilen-Rand
-- set laststatus=2    " Statuszeile immer anzeigen
-- set cmdheight=2     " Mehr Platz für Statusmeldungen
-- set nowrap          " Wrap standardmäßig abschalten. Mit Leader w an-/abschalten
--
-- Wenn man die in der Lua Initdatei benutzen moechte dann mit vim.opt.XYZ = ABC

-- Zeile immer an
vim.o.laststatus = 2

-- Colorschemes
--
-- Eine Liste aller installierten Themes mit dem Befehl 
-- :colorscheme und dann Strg + D drücken. 

-- Das Vim scheme scheint am besten "nichts" zu machen.
vim.cmd.colorscheme("vim")

--
-- Damit moderne Themes korrekt angezeigt werden, solltest du 
-- "True Color"-Support aktivieren:
vim.opt.termguicolors = true



-- Mouse Settings 
--    set mouse=    Deaktiviert die Maus-Interaktion komplett in Neovim.
--    set mouse=a   Erlaubt Maus-Interaktion (Auswählen, Scrollen), aber gibt 
--       auch Terminal-spezifische Maus-Events (wie das Auswählen mit Shift-Taste) 
--       durch, was oft das gewünschte Verhalten ist. 
--
--     Hinweis: Wenn die Maus in Neovim aktiviert ist (=a), kannst du in den 
--     meisten Terminals die Umschalttaste (Shift) gedrückt halten, um temporär 
--     die Mausfunktionen des Terminals (wie z. B. das Kopieren von Text) anstelle 
--     der Neovim-Logik zu nutzen.
--
--    Verfügbare Parameter 
--      n: Normal-Modus.
--      v: Visual-Modus.
--      i: Insert-Modus.
--      c: Command-line-Modus.
--      h: Alle vorherigen Modi, wenn eine Hilfe-Datei (help) bearbeitet wird.
--      a: Alle Modi (entspricht nvich).
--      r: Für die "Hit-enter"- und "More-prompt"-Abfragen (z. B. nach langen Befehlsausgaben).
--vim.o.mouse = a
vim.o.mouse = r


-- [[ Setting options ]] See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

-- Print the line number in front of each line
vim.o.number = true

-- Use relative line numbers, so that it is easier to jump with j, k. 
-- This will affect the 'number' option above, see `:h number_relativenumber`
--vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the line where the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Show <tab> and trailing spaces
--vim.o.list = true
vim.o.list = false

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.o.confirm = true

-- [[ Set up keymaps ]] See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- [[ Basic Autocommands ]].
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

---- Highlight when yanking (copying) text.
---- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
--vim.api.nvim_create_autocmd('TextYankPost', {
--  desc = 'Highlight when yanking (copying) text',
--  callback = function()
--    vim.hl.on_yank()
--  end,
--})


-- [[ Create user commands ]]
-- See `:h nvim_create_user_command()` and `:h user-commands`

---- Create a command `:GitBlameLine` that print the git blame for the current line
-- vim.api.nvim_create_user_command('GitBlameLine', function()
--   local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
--   local filename = vim.api.nvim_buf_get_name(0)
--   print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
-- end, { desc = 'Print the git blame for the current line' })


-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.

-- For example, to add the "nohlsearch" package to automatically turn off 
-- search highlighting after 'updatetime' and when going to insert mode
vim.cmd('packadd! nohlsearch')


---
--- EOF
---
