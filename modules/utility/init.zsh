#
# Defines general aliases and functions.
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Suraj N. Kurapati <sunaku@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
pmodload 'helper' 'spectrum'

# Correct commands.
setopt CORRECT

#
# Aliases
#

# Disable correction.
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias ebuild='nocorrect ebuild'
alias gcc='nocorrect gcc'
alias gist='nocorrect gist'
alias grep='nocorrect grep'
alias heroku='nocorrect heroku'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias rm='nocorrect rm'
alias ll='ls++'
alias tml='tmux list-sessions'
alias tma='tmux attach-session -t'
alias tmn='tmux new-window'
# Disable globbing.
alias bower='noglob bower'
alias fc='noglob fc'
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rake='noglob rake'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'

# Define general aliases.
alias gpsh='git push'
alias gpl='git pull'
alias _='sudo'
alias b='${(z)BROWSER}'
alias cp="${aliases[cp]:-cp} -i"
alias e='${(z)VISUAL:-${(z)EDITOR}}'
alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -i"
alias p='${(z)PAGER}'
alias po='popd'
alias pu='pushd'
alias rm="${aliases[rm]:-rm} -i"
alias type='type -a'
alias h='history -iD'
alias tu='tmux select-pane -U'
alias td='tmux select-pane -D'
alias n='nano -w'

# ls
if is-callable 'dircolors'; then
  # GNU Core Utilities
  alias ls='ls --group-directories-first'

  if zstyle -t ':prezto:module:utility:ls' color; then
    if [[ -s "$HOME/.dir_colors" ]]; then
      eval "$(dircolors --sh "$HOME/.dir_colors")"
    else
      eval "$(dircolors --sh)"
    fi

    alias ls="$aliases[ls] --color=auto"
  else
    alias ls="$aliases[ls] -F"
  fi
else
  # BSD Core Utilities
  if zstyle -t ':prezto:module:utility:ls' color; then
    # Define colors for BSD ls.
    export LSCOLORS='exfxcxdxbxGxDxabagacad'

    # Define colors for the completion system.
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

    alias ls='ls -G'
  else
    alias ls='ls -F'
  fi
fi

alias l='ls -1A'         # Lists in one column, hidden files.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.


# Grep
if zstyle -t ':prezto:module:utility:grep' color; then
  export GREP_COLOR='37;45'           # BSD.
  export GREP_COLORS="mt=$GREP_COLOR" # GNU.

  alias grep="$aliases[grep] --color=auto"
fi

# Mac OS X Everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o='cygstart'
  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
else
  alias o='xdg-open'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

# File Download
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

# Resource Usage
alias df='df -kh'
alias du='du -kh'

if (( $+commands[htop] )); then
  alias top=htop
else
  if [[ "$OSTYPE" == (darwin*|*bsd*) ]]; then
    alias topc='top -o cpu'
    alias topm='top -o vsize'
  else
    alias topc='top -o %CPU'
    alias topm='top -o %MEM'
  fi
fi

# Miscellaneous

# Serves a directory via HTTP.
#alias http-serve='python -m SimpleHTTPServer'
# find out how to check if module is installed and if it is then use this function

#
# Functions
#

# Get current working branch
# Usage: get_git_branch
function get_git_branch { git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'; }

# Checkout a zprezto git branch named after servers hostname
# Usage: githost
function githost { hst=$(hostname -s); cd $HOME/.zprezto; git checkout -b "$hst"; }


# Source .zprezto/modules/utility/init.zsh after adding new functions or aliases
# Usage: rld
function rld { source $HOME/.zprezto/modules/utility/init.zsh; }

# Makes a directory and changes to it.
# Usage: mkdcd /var/foo/bar
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
# Usage: cdls /var/foo/bar
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Shortcut for ssh root@x.x.x.x
# Usage: sr 192.168.1.1 - Accepts -p for port
function sr { ssh root@"$1"; }

# List or search for all exported API users and keys
# Usage: tokens |grep SERVICE // Example for github tokens|grep gh
function tokens {
export | egrep 'api|_usr'
}

#
# Usage:
function notice { echo -e "\e[0;34m:: \e[1;37m${*}\e[0m"; }


# Pushes an entry onto the directory stack and lists its contents.
# Usage:
function pushdls {
  builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Quickly add a new alias to the utility module in prezto
# Usage: adal tdl "todo.sh ls" would create the line alias tdl='todo.sh ls' in modules/utility/init.zsh
function adal {
	 echo "alias $1='$2'" >> ${ZDOTDIR:-$HOME}/.zprezto/modules/utility/init.zsh
}


# Perform a 300 count MTR with and without DNS resolution
# Usage: mtr300 example.com
function mtr300 { echo -e "Performing 300 Count MTR from server $(hostname -f) to $1\n"; mtr -rc 300 $1; notice ~~~~~~~~; mtr -rc 300 -n $1; }

# Pops an entry off the directory stack and lists its contents.
# Usage: popdls
function popdls {
  builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pulls the description of the various FUNCTIONS in "$HOME/.zprezto/modules/utility/init.zsh"
# Usage: define FUNCTION
function define {
 grep -B2 "$@" ${ZDOTDIR:-$HOME}/.zprezto/modules/utility/init.zsh | grep -v function
}

# Removes a conflicting ssh-key from the known hosts file
# Usage: iprem 192.168.0.1
function iprem {
ssh-keygen -f "$HOME/.ssh/known_hosts" -R $1
}

# Get human readable information about files/directories taking up the most space
# Usage: dux /var
function dux() { pwd; du -hs * 2> /dev/null|grep '^[0-9.]\+[MG]'; }

# Prints columns 1 2 3 ... n.
# Usage:
function slit {
  awk "{ print ${(j:,:):-\$${^@}} }"
}

# Upload file to transfer.sh amd get back the download URL
# Usage: transfer /etc/rc.local
function transfer { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }; alias transfer=transfer


# Create a new stikked post from a file - output will be the URL of the stikked post
# Usage: stik "Name" /path/to/file
function stik { curl -d title="$1" -d name='Ryan' --data-urlencode text@$2 http://bebop.tinybot.io/api/create ; }

# Run a mosh connection to a server
# Usage: msh PORT X.X.X.X
function msh { mosh --ssh="ssh -p $1" $2; }

# Download a package from the AUR for Arch Linux
# Usage: aurget plexmediaserver
function aurget { export LASTAURPKG=${1}; wget https://aur.archlinux.org/packages/${1:0:2}/${1}/${1}.tar.gz; }

# Search global zhistory files that have been stored in the ${ZDOTDIR:-$HOME}/.zprezto/hosts directory
# Usage: gblhist SEARCHTERM
function gblhist { find $homebase/hosts -type f -iname "*.zhistory" -print0 | xargs -0 egrep "$@" ; }

# Unpack the most recently downloaded AUR package in Arch Linux
# Usage: aurunpack
function aurunpack { tar -xvzf ${LASTAURPKG}.tar.gz; }

# Search the quickcommands file
# Usage: qc 'string'
function qc { egrep "$@" $HOME/.zprezto/modules/softlayer/quickcommands; }

# Try to decompress common compressed archives.
# Usage: extract file.tar.gz
function extract {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Generate a random 16 digit password with numbers, special characters and Upper and Lowercase letters
# Usage: pwgen
function pwgen { sudo cat /dev/urandom | tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo; }

# Run an aggressive nmap against an IP or setmodules/utility/init.zsh of IP's
# Usage: nm 192.168.1.1
function nm { nmap -P0 -T4 -sV -p- $*; }

# Get IP of system as seen by icanhazip
# Usage: myip
function myip { curl -4 -s icanhazip.com; }

# Get all nameservers for a domain and the A record that each has
# Usage: alldns example.com
function alldns { for NS in $(dig +short NS ${1} | cut -d " " -f 1 | sed 's/\.$//g'); do echo -n "${NS}: "; dig +short ${1} @${NS}; done; }

# Finds files and executes a command on them.
# find-exec file command / Example: find-exec '*.jpg' stat (Find all jpg's and get stat about them)
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
# Usage: psu
function psu {
  ps -U "${1:-$LOGNAME}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

# Get random commands for interacting with Object Storage
# Usage: objstorage
function objstorage { cat $HOME/.zprezto/modules/softlayer/objectstoragecommands; }

function s1ssh {
 file=$HOME/ssh_config
 if [ ! -e "$file" ] ; then
     touch "$file"
 fi
 /usr/bin/ssh -t -F $HOME/ssh_config "$@" "export RUSER=$(whoami) ; echo $(whoami) logging in at $(date) >> .bash_history ; if [ \`uname -n | grep rescue | wc -l\` = 1 ] ; then echo "This is
 rescue" ; if [ ! -f /etc/redhat-release ] ; then apt-get install -y lsof curl screen bc ; else yum -y install bc screen lsof curl smartmontools dos2unix ; fi ; fi ; if [ ! -f
/usr/bin/curl -  a -f /usr/bin/apt-get ] ; then apt-get install -y curl bc lsof screen ; fi ; scr=\`curl -s https://dl.dropboxusercontent.com/u/131462/Work/functions.sh\`;
exec 75<>\`mktemp -u /tmp/  tmp.XXXXXXXXXX\`; printf   \"%s\n\" \"\$scr\" >&75; if [ -e /bin/bash ] ; then /bin/bash --rcfile /dev/fd/75 -i; else /usr/local/bin/bash --rcfile <(curl -s
https://dl.dropboxusercontent.com/u/131462/Work/functions.sh) -i; fi ;" ; }

# Search saved Softlayer KB's from local kb file
# Usage: kb SEARCHSTRING
function kb { egrep "$@" /home/ryan/.zprezto/modules/softlayer/kb; }

# Search the .zhistory file
# Usage: hist thing
function hist { egrep "$@" $HOME/.zhistory; }

# Get Softlayer vs from search term
# Usage: slv NAME
function slv { sl vs list | grep $@ ; }

# Get vs id from search name
# Usage: sli NAME
function sli { sl vs list | grep $@ | awk '{print $1}'; }

# Get details about an sl vs
# Usage: slic NAME
function slic { sl vs detail $(sli $@) --passwords --format=raw ; }

# Get human readable number for file permissions
# Usage: st FILENAME
function st { stat -c '%n %a' "$@"; }

# Netcat with the -v flag on a port scan
# Usage: ncz IP PORT
function ncz { netcat -z -v "$1" "$2"; }


#
#
function nca { sudo netcat -z -n -v "$1" "$2" 2>&1 | grep succeeded; }

#Exports
export ce_api='e27MO4EchBEZ0fUo'
export dns_api='TdTCzZGWFJAK6nHRtP8Q'
export di_api='e6fd7cb520d8e7fa46daf7be76f302b86765f4b0e39e0157749ff53631c4f639'
export wk_usr='ryant'
export wk_api='c00b3d33cb1467d7def58b4390bc63e2aa1a73f7f455cb16c1147db500dc5445'
export sl_api='7be320fe8dbf3c895bc7b1c49610d326e2e093c7772ff760bd54754878580be5'
export sl_usr='SL228638'
export gh_api='d20087d60c2d9dad41654f4408dbfd78b5b79350'

# More Aliases
alias db='/home/ryan/bin/dropbox.py'
alias sn='sudo nano -w'
alias gs='git status'
alias tdl='todo.sh ls'
alias tsw='tmux swap-window'
alias dbp='/home/ryan/bin/dropbox.py puburl'
alias updb='sudo updatedb'
alias tda='todo.sh -a'
alias tda='todo.sh add'
alias tdl='todo.sh ls'
alias tmn='tmux new-window'
alias tlw='tmux list-windows'
