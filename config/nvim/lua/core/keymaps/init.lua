local bind = require('core.keymaps.bind')
Load('core.keymaps.custom_commands').load()

-- By default the options silent and noremap are set for every keymap
-- If you need to disable any, use :no_silent() or :no_remap()
--
-- Common
local map_cmd = bind.map_cmd -- [cmd] Note: dont try to use cmd only, neovim doesnt recognize it
local cr = bind.cr -- :[cmd]<CR>
local lua = bind.lua -- :lua [cmd]<CR>

-- Special bindindings
local lazy = bind.lazy -- :Lazy
local lspsaga = bind.lspsaga -- :Lspsaga
local trouble = bind.trouble -- :Lspsaga
local dap = bind.dap -- :lua require('dap').
local te = bind.te -- :Telescope | if start with `.`, then :lua require('telescope.builtins')

local keymaps = {
--
-- Vim enhancements
--
	-- Navigate on text while on insert mode
	['i|<C-l>'] = map_cmd('<Right>'),
	['i|<C-h>'] = map_cmd('<Left>'),

	-- Delete previous word with Ctrl-Backspace
	['i|<C-BS>'] = map_cmd('<C-\\><C-o>db'),

	-- Exit insert mode shortcuts
	['i|jk'] = map_cmd('<esc>'),
	['n|q'] = cr('x'),
	['n|Q'] = map_cmd('q'),
	['n|<C-c>'] = map_cmd('<Esc>'):desc('Escape'),

	['v|>'] = map_cmd('>gv'),
	['v|<'] = map_cmd('<gv'):no_silent(),

	-- Paste without losing last register
	['n|vv'] = map_cmd('0v$'):desc('Delete only the content of line, not line itself'),
	['n|Y'] = map_cmd('y$'):desc('Yank from cursor til the eol'),
	['n|0'] = map_cmd('_'),
	['n|_'] = map_cmd('0'),
	['n,v|<leader>p'] = map_cmd('"_dP'):desc('Paste without losing current yank'),
	['n|<leader>o'] = map_cmd('mzo<Esc>0"_D`z'),
	['n|<leader>O'] = map_cmd('mzO<Esc>0"_D`z'),

	['i|<C-e>'] = map_cmd('<Esc>A'):no_silent(),
	['i|<C-f>'] = map_cmd('<Esc>I'):no_silent(),

	-- Easily go to end of line
	['n,v|-'] = map_cmd('$'),

	["n,v|'"] = cr('MarksListAll'),

	-- Move line position on Visual mode
	['x|<S-k>'] = map_cmd(":move '<-2<CR>gv-gv"):desc(''),
	['x|<S-j>'] = map_cmd(":move '>+1<CR>gv-gv"):desc(''),

	-- Move between windows
	['n|sj'] = map_cmd('<C-w>j'):desc('Move to window below'),
	['n|sk'] = map_cmd('<C-w>k'):desc('Move to window above'),
	['n|sh'] = map_cmd('<C-w>h'):desc('move to window on left'),
	['n|sl'] = map_cmd('<C-w>l'):desc('Move to window on right'),
	['n|sw'] = map_cmd('<C-w>w'):desc('Move to window on right'),
	['n|sc'] = cr('q'):desc('Kill current window'),
	['n|si'] = map_cmd('<C-^>'):desc('Quick switch to last buffer'),
	['n|sd'] = cr('bdelete'):desc('Quick switch to last buffer'),
	['n|L'] = cr('bnext'):desc('Switch do next buffer'),
	['n|sp'] = cr('bnext'):desc('Switch do next buffer'),
	['n|H'] = cr('bprevious'):desc('Switch to previous buffer'),
	['n|sn'] = cr('bprevious'):desc('Switch to previous buffer'),
	['n|sq'] = cr('xa'):desc('Quit'),
	['n|so'] = cr('BDelete other'):desc('Kill others buffers current least current'),

	-- Resize windows
	['n|<C-A-k>'] = cr('resize +2'):desc('Resize window upward'),
	['n|<C-A-j>'] = cr('resize -2'):desc('Resize window downward'),
	['n|<C-A-h>'] = cr('vertical resize -2'):desc('Resize window to left'),
	['n|<C-A-l>'] = cr('vertical resize +2'):desc('Resize window to left'),

	-- File actions
	['n|<leader>w'] = cr('wall'):desc('Save File'),
	['n|fd'] = cr('wall'):desc('Save File'),
	['n|<leader>x'] = cr('!chmod +x %'):desc('Alter file permission to +x'),

	-- Stay in same line when:
	-- -- Switch searches
	['n|n'] = map_cmd('nzzzv'),
	['n|N'] = map_cmd('Nzzzv'),
	-- -- Join lines
	['n|J'] = map_cmd('mzJ`z'),
	-- -- Formatting paragraph
	['n|fp'] = map_cmd('mz=ap`zk'):desc('Format paragraph'):no_remap(),
	['n|=='] = map_cmd('mz=ap`zk'):desc('Format paragraph'):no_silent(),

--
-- Plugins
--
	-- Copilot
	["n,i|<A-;>"] = map_cmd('<Plug>(copilot-suggest)'):desc('Copilot Suggest'),

	-- DAP: Debugger Adapter Protocol
	['n|,p'] = dap('step_out()'):desc('Step out (prev)'),
	['n|,d'] = dap('continue()'):desc('Open dap interface'),
	['n|,l'] = dap('run_last()'):desc('Run last'),
	['n|,m'] = dap('step_over()'):desc('step Over'),
	['n|,n'] = dap('step_into()'):desc('step Into (next)'),
	['n|,o'] = dap('repl.open()'):desc('REPL Open'),
	['n|,r'] = dap('run_to_cursor()'):desc('Run to Cursor'),
	['n|,c'] = dap("terminate() require('dapui').close()"):desc('Close'),
	['n|,B'] = dap("set_breakpoint(vim.fn.input('Breakpoint condition: '))"):desc('set breakpoint with conditions'),
	['n|,b'] = dap("toggle_breakpoint()"):desc('set Breakpoint'),

	-- LSP
	['n|<leader>lf'] = cr('Format'):desc('LSP: format file'),
	['n|<leader>li'] = cr('LspInfo'):desc('LSP: Info'),
	['n|<leader>lr'] = cr('LspRestart'):desc('LSP: Info'),

	-- Mason
	['n|<leader>lm'] = cr('Mason'):desc('Mason: open'),

	-- Noice
	-- Nvimtree
	['n|<leader>pe'] = cr('NvimTreeToggle'):desc('Explorer'),
	--['n|<leader>pr'] = cr('NvimTree root'):desc('Explorer: cwd'),
	['n|<leader>.']  = cr('NvimTreeToggle'):desc('Explorere'),

	-- Trouble
	['n|<leader>tt'] = trouble(''):desc('Toggle Trouble'),
	['n|<leader>tw'] = trouble('workspace_diagnostics'):desc('Workspace diagnostics'),
	['n|<leader>td'] = trouble('document_diagnostics'):desc('Document diagnostics'),
	['n|<leader>tl'] = trouble('loclist'):desc('Loclist'),
	['n|<leader>tq'] = trouble('quickfix'):desc('Quick fix'),
	['n|<leader>tr'] = trouble('lsp_references'):desc('References'),

	-- Lazy
	['n|<leader>lo'] = lazy(''):desc('[O]pen'),
	['n|<leader>ll'] = lazy('log'):desc('[L]og'),
	['n|<leader>lc'] = lazy('check'):desc('[C]heck'),
	['n|<leader>ld'] = lazy('debug'):desc('[D]ebug'),
	['n|<leader>lu'] = lazy('update'):desc('[U]pdate'),

	-- LspSaga
	-- ['n|K'] = lspsaga('hover_doc'):desc('Hover documentation'), -- See below
	['n,v|ga'] = lspsaga('code_action'):desc('Code actions'),
	['n|gh'] = lspsaga('lsp_finder'):desc('Finder'),
	['n|go'] = lspsaga('outline'):desc('Go to outline'),
	['n|gd'] = lspsaga('peek_definition'):desc('Peek definition'),
	['n|gD'] = lspsaga('goto_definition'):desc('Go to definition'),
	['n|gr'] = lspsaga('rename'):desc('Rename inside file'),
	['n|gR'] = lspsaga('rename ++project'):desc('Rename in whole project'),
	['n|ge'] = lspsaga('show_line_diagnostics'):desc('Show Line diagnostics'),
	['n|gp'] = lspsaga('diagnostic_jump_prev'):desc('Jump next diagnostic'),
	['n|gn'] = lspsaga('diagnostic_jump_next'):desc('Jump previous diagnostic'),
	['n|gs'] = lua('vim.lsp.buf.signature_help()'):desc('Go to Signature'),
	['n|gb'] = lspsaga('show_buf_diagnostics'):desc('Show Buffer diagnostics'),

	['n|<Leader>ci'] = lspsaga('incoming_calls'):desc('Incoming Calls'),
	['n|<Leader>co'] = lspsaga('outgoing_calls'):desc('Outgoing Calls'),

	-- Telescope
	['n|<leader>sp'] = te('project'):desc('Projects'),
	['n|<leader>sh'] = te('.help_tags()'):desc('Search help'),
	['n|<leader>sk'] = te('.keymaps()'):desc('Search keymaps'),
	['n|<leader>sd'] = te('.diagnostics()'):desc('Search diagnostics'),

	-- Treesitter
	['n|\\th'] = cr('TSNodeUnderCursor'):desc('[Treesitter]: Playground!'),
	['n|\\tc'] = cr('TSHighlightCapturesUnderCursor'):desc('[Treesitter]: Playground!'),
	['n|\\tt'] = cr('TSPlaygroundToggle'):desc('[Treesitter]: Playground!'),

	-- Treesitter Node Action
	['n|U'] = lua('require("ts-node-action").node_action()'):desc('Trigger Node Action'),

	-- Undotree
	['n|<A-u>'] = cr('UndotreeToggle'):desc('Undotree'),

	-- Vim Multiple cursors
	['n|<M-k>'] = map_cmd('<Plug>(VM-Add-Cursor-Up)'):desc('Move to window below'),
	['n|<M-j>'] = map_cmd('<Plug>(VM-Add-Cursor-Down)'):desc('Move to window below'),
	['n|<C-LeftMouse>'] = map_cmd('<Plug>(VM-Mouse-Cursor)'):desc(''),
	['n|<C-RightMouse>'] = map_cmd('<Plug>(VM-Mouse-Word)'):desc('Move to window below'),
	['n|<M-C-RightMouse>'] = map_cmd('<Plug>(VM-Mouse-Column)'):desc( 'Move to window below'),
	['n|<leader>;'] = map_cmd('<Plug>(VM-Add-Cursor-At-Pos)'):desc( 'Move to window below'),

	-- Zen mode
	['n|\\z'] = cr('ZenMode'):desc('Explorer'),

-- Personal
	['n|<leader>,'] = cr('Custom local_git'):desc('Browse local files'),
	['n|ft'] = te('frecency'):desc('Frecency'),
	['n|fo'] = te('zoxide'):desc('Frecency'),
	['n|fw'] = te('.live_grep()'):desc('Search word with grep'),
	['n|fg'] = te('.git_files()'):desc('Find files added on git'),
	-- ['n|ff'] = te('.find_files()'):desc('Find files added on git'),
	['n|fc'] = cr('Custom config'):desc('Search Config'),
	['n|fe'] = cr('Custom local_recent'):desc('Find local recent'),
	['n|fr'] = cr('Telescope frecency'):desc('find global Recent'),

	-- -- Special
	['n|<leader>/']  = te('.live_grep()'):desc('Search grep'),
	['n|<leader><space>'] = te('.buffers()'):desc('Search buffers'),

--
-- Languages
	-- Rust
	['n|<leader>rr'] = lua('_Rust_toggle()'):desc('[Rust]: Bacon'),
	['n|<leader>rc'] = cr('!cargo check'):desc('[Rust]: Check'),
	['n|<leader>rf'] = cr('!rustfmt'):desc('[Rust]: Format'),
	['n|<leader>ra'] = cr('RustHoverActions'):desc('[Rust]: Hover Actions'),
	['n|<leader>rk'] = cr('RustHoverRange'):desc('[Rust]: Hover Range'),
	['n|<leader>roc'] = cr('RustOpenCargo'):desc('[Rust]: Open Cargo'),
	['n|<leader>rg'] = cr('RustViewCrateGraph'):desc('[Rust]: View Crate Graph'),
	['n|<leader>rs'] = cr('RustSSR'):desc('[Rust]: Structural Search Replace'),
	['n|<leader>rj'] = cr('RustJoinLines'):desc('[Rust]: Join Lines'),
	['n|<leader>rp'] = cr('RustParentModule'):desc('[Rust]: Parent Module'),
	['n|<leader>rm'] = cr('RustExpandMacro'):desc('[Rust]: Expand Macro!'),
}

bind.load_mapping(keymaps)

local function show_documentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ 'vim','help' }, filetype) then
        vim.cmd('h '..vim.fn.expand('<cword>'))
    elseif vim.tbl_contains({ 'man' }, filetype) then
        vim.cmd('Man '..vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
        require('crates').show_popup()
    else
	vim.cmd(":Lspsaga hover_doc <CR>")
    end
end

vim.keymap.set('n', 'K', show_documentation, { silent = true })
