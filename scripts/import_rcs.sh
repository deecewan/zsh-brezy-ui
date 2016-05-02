#!/bin/bash

touch ~/.zshrc

cat <<EOF >> ~/.zshrc
# User configuration
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
EOF

case $1 in
  [Yy]* )
    cat <<- EOF >> ~/.zshrc
	
	# Oh my zsh path and source
	export ZSH=~/.oh-my-zsh
	source \$ZSH/oh-my-zsh.sh
	EOF
    ;;
esac

if [[ $3 = [Yy]* ]]; then
	GITEXTRAS=" git-extras"
else
	GITEXTRAS=""
fi

cat <<EOF >> ~/.zshrc

# Current plugins " >> ~/.zshrc
plugins=(git brew npm bower extract z$GITEXTRAS)
# Red dots whilst waiting for completion
COMPLETION_WAITING_DOTS=\"true\"
# History command. options: \"mm/dd/yyyy\"|\"dd.mm.yyyy\"|\"yyyy-mm-dd\"
HIST_STAMPS=\"dd.mm.yyyy\"
EOF

case $2 in
  [Yy]* )
    cat <<-EOF >> ~/.zshrc

	# PROMPT 
	source ~/.git-prompt.sh
	GIT_PS1_SHOWCOLORHINTS='1'
	GIT_PS1_SHOWDIRTYSTATE='1'
	GIT_PS1_SHOWSTASHSTATE='1'
	GIT_PS1_SHOWUNTRACKEDFILES='1'
	precmd() { __git_ps1 \"%F{4}%n@%m%f %F{1}[%~]%f \" \"$ \" \"{%s} \" }
	EOF
    ;;
esac

cat <<EOF >> ~/.zshrc

# Activate advanced completions
zstyle ':completion:*' menu select

# Enable colors
zstyle ':completion:*:default' list-colors ''
export CLICOLOR='1'
EOF

echo "\nrun commands imported\n"
