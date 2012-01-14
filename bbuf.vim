function! Bbuf()

	redir => buflist
	silent ls
	redir END

	let bufitems = split(buflist, "\n")
	echo "\n"
	for i in bufitems
		let step1 =  substitute(i, '[^ ]\zs  \+', ' ', 'g')
		let step2 = split(step1, '"')
		echo "[" . split(step2[0]," ")[0] . "] " . step2[1]
	endfor

	echo "\n"
	let buf_num = input("Buffer number: ")
	execute("b " . buf_num)
	
endfunction

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
		execute("normal i [" . split(step2[0]," ")[0] . "] " . step2[1] . "\n")
	endfor

	map <buffer> <2-LEFTMOUSE> :call Bbuf_open()<CR>
	map <buffer> <CR> <2-LEFTMOUSE>
	map <buffer> <F9> :bd!<CR>
	map <buffer> <Esc> :bd!<CR>
	autocmd WinLeave <buffer> execute("bd!")
endfunction

function! Bbuf_open() 
	let l:nobrackets = substitute(getline("."), '[\[\]]', '', 'g')
	let l:buf_num = split(l:nobrackets, ' ')[0]
	bd!
	wincmd p
	execute("b " . l:buf_num)
endfunction
