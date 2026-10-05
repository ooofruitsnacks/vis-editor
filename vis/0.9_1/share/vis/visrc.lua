-- load standard vis module, providing parts of the Lua API
require('vis')
-- Automatically use the Odin lexer for .odin files.
vis.ftdetect.filetypes.odin = {
  ext = { '%.odin$' },
  }

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
vis:command("set tabwidth 4")
vis:command("set numbers true")
vis:command("set autoindent true")
vis:command("set showspaces false")
vis:command("set showtabs false")
vis:command("set expandtab off")
end)

-- plugins

