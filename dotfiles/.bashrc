# This file is sourced by all *interactive* bash shells on startup.  This
# file *should generate no output* or it will break the scp and rcp commands.

# colors for ls, etc.
# eval `dircolors -b /etc/DIR_COLORS`
alias d="ls --color"
alias ls="ls --color=auto"
alias ll="ls --color -l"

alias vg="valgrind --tool=memcheck"
alias pixie="valgrind --tool=cachegrind"

# Change the window title of X terminals 
case $TERM in
	xterm*|rxvt|eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

PATH=~/bin:$PATH

# Add LLVM development binaries
PATH=~/projects/repo/llvm/Release+Asserts/bin:$PATH

# Add PIN
PIN_ROOT=/home/andrew/pin-2.13-62141-gcc.4.4.7-linux
export PIN_ROOT

PATH=$PIN_ROOT:$PATH

# Add Altera
PATH=/home/andrew/altera/13.1/quartus/bin:$PATH
PATH=/home/andrew/altera/13.1/modelsim_ase/bin:$PATH

EDITOR=vim
export EDITOR

