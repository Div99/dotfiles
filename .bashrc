# Source global definitions
if [[ -f /etc/bashrc ]]; then
    . /etc/bashrc
fi

# Make default editor vim
export EDITOR='vim'

# Git goodness
source ~/.git-completion.bash
source ~/.git-prompt.sh

CYAN='\[\033[36m\]'
RED='\[\033[1;31m\]'
GREEN='\[\033[1;32m\]'
YELLOW='\[\033[33m\]'
WHITE='\[\033[m\]'

# If ssh session, include hostname in prompt
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    export PS1="$CYAN\\u$RED@$GREEN\\h$WHITE:$YELLOW\\w$RED\$(__git_ps1)$WHITE> "
else
    export PS1="$CYAN\u$WHITE:$YELLOW\w$RED\$(__git_ps1)$WHITE> "
fi
export CLICOLOR=1

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS="true"
export GIT_PS1_STATESEPARATOR=""

# OS Specific Aliases
OS=$(uname)
case "$OS" in
    'Darwin')
        export LSCOLORS='ExFxBxDxCxegedabagacad'
        alias ls='ls -FhG'
        ;;
    'Linux')
        export LS_COLORS='di=1;35;40:ln=1;35;40:so=1;31;40:pi=1;33;40:ex=1;32;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
        alias ls='ls -Fh --color=always'

        # Regular open doesn't do what we want; xdg-open *should* exist on all Linux platforms.
        # This is a "function", which we will cover later with scripting.
        #
        #     - The $@ says "take ALL inputs", allowing for say `open *.txt`
        #     - The &> is a shorthand for 2>&1 for bash 4.0+
        #         - We are sending it to /dev/null because we don't care what it has to say (usually)...
        open () {
            xdg-open "$@" &>/dev/null
        }

        # I want to be able to run vlc from the commandline without any output, and let it keep running after
        # I close my terminal (nohup).
        #
        # Of course...you have to have vlc installed.
        # vlc () {
        #     nohup "$(which vlc)" "$@" &>/dev/null &
        # }
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

# Import bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Sublime aliases
function s {
  if [ "$1" != "" ]; then
    subl "$1"
  else
    subl "$PWD"
  fi
}

#
# Thank you: http://madebynathan.com/2011/10/04/a-nicer-way-to-use-xclip/
#
# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
#
# Note: I changed my alias to 'clip', which is different from the original.
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}
# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
function clip() { cat "$1" | cb; }
# Copy SSH public key
alias clipssh="clip ~/.ssh/id_rsa.pub"
# Copy current working directory
alias clipwd="pwd | cb"
# Copy most recent command in bash history
alias cliphs="cat $HISTFILE | tail -n 1 | cb"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f 2-)" ssh scp ftp lftp sftp

