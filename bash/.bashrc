# ~/.bashrc: executed by bash(1) for non-login shells.
# |  order  | file                |    Note                                   |
# |---------|:-------------------:|-------------------------------------------|
# | &&      | AND upon successful exit (0) will execute next command          |
# | ||      | OR upon failure exit (non-zero) will execute next command       |
# | for loop| for x in {1..9}; do echo "$(cat ${x})" ; done                   |
# | while   | while : ; do ls -l ./file/to/watch ; done                       |
# | if      | if [[ $(grep "ok") =~ $(curl web/status) ]]; then print ok ; fi | 
# | elif    | if [[ $? == '0' ]] then ;    elif [[ $? >= '1' ]] ; else ; fi   |
# | IFS     | internal field seperator: IFS=, grep 'value' -B2 /tmp/file.csv  |
# | sed     | remove new lines:  sed -e':a;N;$!ba;s/\n/ /g'                   |
# | awk     | NR/NF=number of records/fields: awk '{print ; if (NR == 8)}'    |
# | awk     | search pattern > 32 print awk '/pattern/{print $3} ;length > 32'|
# | process | diff <(ls dir) <(ls other/dir)                                  | 
# | math    | (()) $((`df --output=used /dev/mapper/vglv|grep [0-9]` / 1024)) |
# | redirect| dnf update -y 2>&1 | tee -a stderr/and/stdout/file.out          |
# | words   | echo ${remove_first_two-then_last:2:2} negative values work     |
# | expand  | expand variables: echo ${!GO*} checks all GO_* variables, arrays| 
# | removal | % removes from end, # begin ex: mv all_files.txt ${FILENAME%.*} |
# | switch  | swap all to "production" ${STRING_VAR//development/production}  |
# | arrays  | remove error from array: echo "${array[@]//error/}"             |
# | default | set default value: read -p "ip address" IP; VAL=${IP:127.0.0.1} |
# | 
# | 
# | 
# | 
# | 
# Above reserved for Helpy function
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=7000
HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S  "
HISTCONTROL=ignoredups
export PROMPT_COMMAND='history -a'

# Aliases (quick) Functions are better, please be careful with these
alias vi=vim
alias ll='ls -alF' #I almost never use ls commands, these are here for others
alias la='ls -A'
alias l='ls -CF'
# https://www.digitalocean.com/community/questions/what-are-your-favorite-bash-aliases
# If the last character of the alias value is a blank, then the next command 
# word following the alias is also checked for alias expansion.
# 
alias sudo='sudo '
alias time='/usr/bin/time'
alias rsync='rsync -Phav --skip-compress=gz '
alias gpg='gpg2'
#likely, GOROOT, would be incorrect, this is not portable
#export GOROOT=$HOME/workspace/go
export GOPATH=$HOME/workspace/go/packages
export PATH=$PATH:$GOPATH/bin:$HOME/workspace/bin/

function helpy {
    case $1 in
        bashrc)
            head -n 26 | cut -b 2-80 ~/.bashrc 
            ;;
        ssh)
            head -n 26 | cut -b 2-80 ~/.ssh/config
            ;;
        screen)
            head -n 26 | cut -b 2-80 ~/.screenrc 
            ;;
        tmux)
            head -n 26 | cut -b 2-80 ~/.tmux.conf
            ;;
        gpg|gpg2)
            head -n 26 | cut -b 2-80 ~/.gnupg
            ;;
        vim|vi)
            head -n 26 | cut -b 2-80 ~/.vimrc
            ;;
        emacs)
            head -n 26 | cut -b 2-80 ~/.emacs
            ;;
        mutt)
            head -n 26 | cut -b 2-80 ~/.muttrc
            ;;
        aws)
            head -n 26 | cut -b 2-80 ~/.aws/config
            ;;
        git)
            head -n 26 | cut -b 2-80 ~/.gitconfig
            ;;
        *)
            printf "Only a few commands are supported at the moment\n"
            printf "bashrc, ssh, screen, tmux, gpg, vim, mutt, emacs, aws, git"
            ;;
     esac
}
#function alert() {
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# I only disabled this because it was ruining vim's syntax highlighting, I have never used this alias/function
# I am not so sure about 'alert' as the keyword, I would have thought there would be a conflict
#  notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"
#}
function ssh-gpg() {
# so you can view what keys are loaded into gpg's ssh keyring
# I need to add an argument -d, to delete a specified key, like ssh-add
    grep -aoe "comment.*$" ~/.gnupg/private-keys-v1.d/*
}

function reload_buffers() {
    printf "Warning running super user command to clear cache/buffers\n"
    read -p "Proceed? (y/b/c/n)" PROCEED_BUFFC
    if [[ ${PROCEED_BUFFC} == "y" ]]; then
        sudo echo 3 > /proc/sys/vm/drop_caches
    elif [[ ${PROCEED_BUFFC} == "b" ]]; then
        sudo echo 2 > /proc/sys/vm/drop_caches
    elif [[ ${PROCEED_BUFFC} == "c" ]]; then
        sudo echo 1 > /proc/sys/vm/drop_caches
    fi
}

# set or unset AWS environment variable
function aws_key_export() {
  cred_arry=$(awk -v var=${1} 'c&&c--; { if (match($1, var)){ c=2 }}' ~/.aws/credentials |sed -e 's/ //g')
  readarray cred_arry < <(awk -v var=${1} 'c&&c--; { if (match($1, var)){ c=2 }}' ~/.aws/credentials |sed -e 's/ //g')
  
  export AWS_ACCESS_KEY_ID=${cred_arry[0]:18}
  export AWS_SECRET_ACCESS_KEY=${cred_arry[1]:22}
}
## Reloads! it doesn't seem like reload*... is used, or if it is, I don't
# have the packages installed, so I am using it for many of my refresh commands
function reload_tmux_env() {
  eval $(tmux show-env -s |grep '^SSH_')
}
function reload_tmux_env() {
  eval $(tmux show-env -s |grep '^SSH_')
}

function reload_gpg() {
  gpg-connect-agent reloadagent /bye
}

function xtract_ab() {
#extract adb backup one-liner found on SO
  ( printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" ; tail -c +25 backup.ab ) |  tar xfvz -
}

function xtract_rpm() {
#extract adb backup one-liner found on SO
  rpm2cpio ${1} | cpio -idmv
}

function reload_smux () {
  find ~/.ssh -type s -name "C_*" -depth 1 -delete
}
function reload_disk () {
  disk=$1
  sudo "echo '- - -' > /sys/class/scsi_host/$disk_host/scan"
}

function genpasswd() { 
  local l=$1
  [ "$l" == "" ] && l=16
  tr -dc A-Za-z0-9_.,@^ < /dev/urandom | head -c ${l} | xargs 
}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# set a fancy prompt (non-color, unless we know we "want" color)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [[ -n "$force_color_prompt" || ${TERM} =~ "*-256color" || ${TERM} =~ "xterm-color" ]]; then
  if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  # colored GCC warnings and errors
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\[\033[01;32m\]\u_1@\h:\[\033[01;34m\]\W\$ \[\033[00m\]'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#GPG

GPG_TTY=$(tty)
export GPG_TTY

if [ ! -S /run/user/${UID}/gnupg/S.gpg-agent.ssh ]; then
  eval $(gpg-agent --enable-ssh-support --sh --daemon )
elif [[ -z "$SSH_AUTH_SOCK" || -z "$SSH_AGENT_PID" ]]; then
  export SSH_AUTH_SOCK=/run/user/${UID}/gnupg/S.gpg-agent.ssh
  export SSH_PID_OLD=${SSH_AGENT_PID}
  export SSH_AGENT_PID=$(pgrep -u ${USER} gpg-agent)
  export SSH_ASKPASS=/usr/bin/pinentry
elif [[ -S ~/.gnupg/S.gpg-agent.extra ]]; then
  export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.extra
fi

