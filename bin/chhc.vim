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

function Chhc(arg)
	let basedir = fnamemodify(a:arg, ":h")
	let filename = fnamemodify(a:arg, ":t")
	let base = fnamemodify(a:arg, ":r")
	let suffix = fnamemodify(a:arg, ":e")
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
					let target = tmp_c
					break
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
					" There's no relpath() in vim, so change the current directory to the header directory just to allow us to get the relative path using fnamemodify ":."
					let habspath = fnamemodify(fnamemodify(target, ":p"), ":h")
					let cabspath = fnamemodify(basedir, ":p")
					execute ":chdir ".habspath
					let crelpath = fnamemodify(cabspath, ":~:.")
					execute ":chdir ".cabspath
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
