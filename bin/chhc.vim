"Function names must begin with a capital letter
function ReplaceTarget(target, candidate)
	if filereadable(a:candidate)
		return a:candidate
	endif
	return a:target
endfunction

function InList(list, key)
	for val in a:list
		if val ==# a:key
			return 1
		endif
	endfor
	return 0
endfunction

"Get the relative path from absolute path 'from' to absolute path 'to'
function RelPath(to, from)
	let to_arr = split(a:to, '/')
	let from_arr = split(a:from, '/')
	let i = 0
	while i < min([len(to_arr), len(from_arr)])
		if to_arr[i] !=# from_arr[i]
			break
		endif
		let i = i+1
	endwhile
	let path = ''
	let j = i
	while j < len(from_arr)
		let path = path . '../'
		let j = j+1
	endwhile
	let j = i
	while j < len(to_arr)
		let path = path . to_arr[j] . '/'
		let j = j+1
	endwhile
	return path
endfunction

function Chhc(arg)
	let basedir = fnamemodify(a:arg, ":h")
	let filename = fnamemodify(a:arg, ":t")
	let base = fnamemodify(filename, ":r")
	let suffix = fnamemodify(filename, ":e")
	"Lists all on one line
	let csuffixes = [ 'cpp', 'C', 'c', 'cc' ]
	let hsuffixes = [ 'h', 'H', 'hpp' ]
	let hpatterns = [ '../h/%s_export.h', '../../h/%s_sys.h' ]
	let dotchhc = fnamemodify('~/.chhc', ":p")
	let target = ''
	if InList(hsuffixes, suffix)
		for target_suffix in csuffixes
			let candidate = basedir . '/' .  base . '.' . target_suffix
			let target = ReplaceTarget(target, candidate)
		endfor
		if target == '' && filereadable(dotchhc)
			for line in readfile(dotchhc)
				let tmp = split(line, " ")
				let tmp_h = tmp[0]
				let tmp_c = tmp[1]
				if tmp_h ==# filename
					let candidate = basedir . '/' . tmp_c
					let target = ReplaceTarget(target, candidate)
				endif
			endfor
		endif
	endif
	if InList(csuffixes, suffix)
		for target_suffix in hsuffixes
			let candidate = basedir . '/' .  base . '.' . target_suffix
			let target = ReplaceTarget(target, candidate)
		endfor
		if target == ''
			for target_pattern in hpatterns
				let pattern = printf(target_pattern, base)
				let candidate = basedir . '/' .  pattern
				let target = ReplaceTarget(target, candidate)
			endfor
			if target != ''
				let hfile = fnamemodify(target, ":t")
				let found = 0
				if filereadable(dotchhc)
					for line in readfile(dotchhc)
						let tmp = split(line, " ")
						let tmp_h = tmp[0]
						let tmp_c = tmp[1]
						if tmp_h ==# hfile
							let found = 1
							break
						endif
					endfor
				endif
				if !found
					let habspath = fnamemodify(target, ":p:h")
					let cabspath = fnamemodify(basedir, ":p")
					let crelpath = RelPath(cabspath, habspath)
					let cpath = crelpath . filename
					let cmd = printf('echo "%s %s" >> %s', hfile, cpath, dotchhc)
					let rval = system(cmd)
				endif
			endif
		endif
	endif
	if target == ''
		let target = a:arg
	endif
	return target
endfunction
