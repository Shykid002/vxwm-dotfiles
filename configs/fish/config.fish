if status is-interactive

	# Commands to run in interactive sessions can go here
  set -U fish_greeting
  
  zoxide init fish | source

  oh-my-posh init fish --config ~/.config/oh-my-posh/patriksvensson.omp.json | source

  # MY EDITOR
  set -gx EDITOR nvim
	set -gx VISUAL nvim
  
  # MY QT THEME
  
  set -gx QT_QPA_PLATFORMTHEME qt6ct
  set -gx QT_STYLE_OVERRIDE kvantum

  alias c="clear"
  alias ff="fastfetch"
  alias install="paru -S"
  alias remove="paru -Rns"
  alias search="paru"
	alias doas="sudo"
  # Modern eza replacements for ls
  alias ls="eza --icons --group-directories-first -lh"
  alias la="eza --icons --group-directories-first -a"
  alias ll="eza --icons --group-directories-first -lh --git"
  alias tree="eza --icons --tree --level=2"

  # kitty aliases
  alias kh="kitty @ launch --location=hsplit"
  alias kv="kitty @ launch --location=vsplit"

end
