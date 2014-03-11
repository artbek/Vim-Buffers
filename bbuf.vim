" list buffers in new window
function! Bbuf2()

	redir => buflist
	silent ls
	redir END

	let bufitems = split(buflist, "\n")
	bo new
	set nowrap
	let &l:statusline = "Buffers list"
	let l:ws = len(bufitems) + 1
	echom l:ws
	execute("resize " . l:ws)
	for i in bufitems
		let step1 = substitute(i, '[^ ]\zs  \+', ' ', 'g')
		let step2 = split(step1, '"')
		let path_items = split(step2[1], '/')
		let file_flags = split(step2[0], " ")[1]
		if (strlen(file_flags) > 1)
			let file_current = file_flags
		else
			let file_current = "  "
		endif
		execute("normal i" . file_current . " [" . split(step2[0]," ")[0] . "] " . path_items[len(path_items) - 1] . " (" . step2[1] . ")\n")
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
	let l:nobrackets = split(getline("."), '[\[\]]')
	if (len(l:nobrackets) > 1)
		let l:buf_num = l:nobrackets[1]
		bd!
		wincmd p
		execute("b " . l:buf_num)
	endif
endfunction

