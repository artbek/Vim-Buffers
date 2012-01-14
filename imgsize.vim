function! InsertImageSize(filepath) 



python << endp

import vim
from PIL import Image

filepath = vim.eval("a:filepath")
width, height = Image.open(filepath).size
vim.command("let l:width = " + str(width))
vim.command("let l:height = " + str(height))

endp
	
echom l:width
echom l:height

endfunction


