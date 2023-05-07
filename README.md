# Neovim config

Keymaps
=======


- <space> ff: open file
- <space> fg: find in files
- <space> fb: find buffer
- C-v: in telescope open file in vertical split
- C-x: in telescope open file in horizontal split

- [b => previous buffer 
- ]b => next buffer
- C-6 => alternate 

- <control+Up/Dpwm>: incremental selection
- <bs>: decrement selection

- zR/zC: close/open recursively all folds
- K: to preview the fold
- Tab when preview the fold: to get the cursor inside the preview
- q in the preview: to quit

- `gcc`: comment current line or selection (line mode)
- `gbc`: comment in block mode

- `:LspInfo` to see if the current buffer has a LSP active
- `:LspInstall` to install Lsp server 

- `<space>gg`: open neogit

LSP Keymaps
===========

- `K`: display hover information of the element
- `gd`: jump to definition
- `gD`: jump to declaration -- not all servers implements this
- `gi`: list all implementation for the symbol in cursor
- `go`: jump to the definition of the type of the symbol under cursor
- `gr`: list references
- `gs`: display signature
- `F2`: rename references
- `F3`: format current buffer
- `F4`: select code action available
- `gl`: show diagnostic in floating window
- `[d`: move to prev diagnostic in current buffer
- `]d`: move to next diagnostic

- C-space: force autocomplete cmp selection
- C-y: accepts
- C-e: aborts

Windows
========
- C-w h/j/k/l: move to pane in that direction
- C-w w: move to previous pane
