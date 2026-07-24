if status is-interactive

	# Commands to run in interactive sessions can go here
  set -U fish_greeting


	set -gx EDITOR nvim
	set -gx VISUAL nvim
  
  alias install="paru -S"
  alias remove="paru -Rns"
  alias search="paru"
	alias doas="sudo"
	alias la="ls -A"
	alias ls="ls -lh"
end
