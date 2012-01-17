" list buffers in messages area (no mouse events)
function! Bbuf()

	redir => buflist
	silent ls
	redir END

	let bufitems = split(buflist, "\n")
	echo "\n"
	for i in bufitems
		let step1 =  substitute(i, '[^ ]\zs  \+', ' ', 'g')
		let step2 = split(step1, '"')
		let path_items = split(step2[1], '\')

		echo "[" . split(step2[0]," ")[0] . "] " 
		echon path_items[len(path_items) - 1]
		echohl Comment
		echon " (" . step2[1] . ")"
		echohl None

	endfor
	let bn = input("\nBuffer number:")

	execute("b ".bn)
	"@=

endfunction

" list buffers in new window
function! Bbuf2()

	redir => buflist
	silent ls
	redir END

	let bufitems = split(buflist, "\n")
	bo new
	let &l:statusline = "Buffers list"
	let l:ws = len(bufitems) + 1
	echom l:ws
	execute("resize " . l:ws)
	for i in bufitems
		let step1 =  substitute(i, '[^ ]\zs  \+', ' ', 'g')
		let step2 = split(step1, '"')
		let path_items = split(step2[1], '\')
		execute("normal i [" . split(step2[0]," ")[0] . "] " . path_items[len(path_items) - 1] . " (" . step2[1] . ")\n")
	endfor
	match Comment /(.*)/

	map <buffer> <2-LEFTMOUSE> :call Bbuf_open()<CR>
	map <buffer> <CR> <2-LEFTMOUSE>
	map <buffer> <F9> :bd!<CR>
	map <buffer> <Esc> :bd!<CR>
	autocmd WinLeave <buffer> execute("bd!")
endfunction

" open double-clicked buffer
function! Bbuf_open() 
	let l:nobrackets = substitute(getline("."), '[\[\]]', '', 'g')
	let l:buf_num = split(l:nobrackets, ' ')[0]
	bd!
	wincmd p
	execute("b " . l:buf_num)
endfunction
