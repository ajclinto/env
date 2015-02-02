#!/usr/bin/env python -S
import sys
import os

def replace_target(target, candidate):
	if not target and os.path.exists(candidate):
		return candidate
	return target

if len(sys.argv) != 2:
	sys.exit()

(basedir, filename) = os.path.split(sys.argv[1])
(base, suffix) = os.path.splitext(filename)

csuffixes = {
	'.cpp',
	'.C',
	'.c',
	'.cc'
}

hsuffixes = {
	'.h',
	'.H',
	'.hpp'
}

hpatterns = [
	'../h/%s_export.h',
	'../../h/%s_sys.h'
]

dotchhc = os.path.expanduser('~/.chhc')
target = ''

if suffix in hsuffixes:
	for target_suffix in csuffixes:
		candidate = os.path.join(basedir, base + target_suffix)
		target = replace_target(target, candidate)
	if not target and os.path.exists(dotchhc):
		for line in open(dotchhc).readlines():
			tmp = line.rstrip().split(' ')
			tmp_h = tmp[0]
			tmp_c = tmp[1]
			if tmp_h == filename:
				target = tmp_c
				break;

elif suffix in csuffixes:
	for target_suffix in hsuffixes:
		candidate = os.path.join(basedir, base + target_suffix)
		target = replace_target(target, candidate)
	if not target:
		for target_pattern in hpatterns:
			candidate = os.path.join(basedir, target_pattern % base)
			target = replace_target(target, candidate)
		if target:
			hfile = os.path.basename(target)
			found = False
			if os.path.exists(dotchhc):
				for line in open(dotchhc).readlines():
					tmp = line.rstrip().split(' ')
					tmp_h = tmp[0]
					tmp_c = tmp[1]
					if tmp_h == hfile:
						found = True
						break;
			if not found:
				hpath = os.path.dirname(os.path.abspath(target))
				cpath = os.path.relpath(basedir, hpath)
				cpath = os.path.join(cpath, filename)
				os.system('echo "%s %s" >> %s' % (hfile, cpath, dotchhc))

if not target:
	target = filename

print target
