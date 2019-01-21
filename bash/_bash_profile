# .bash_profile
# |  order  | file                |    Note                                   |
# |---------|:-------------------:|-------------------------------------------|
# | login 1 | /etc/profile        | interactive (graphical, su - or --login   |
# | inter 1 | /etc/bashrc         | bash specific settings                    |
# | login 2 | $HOME/.bash_profile | Should be simple                          |
# | login 3 | $HOME/.profile      | ideally executed once                     |
# | login 4 | $HOME/.bash_login   | upon login, will/can load bashrc (RH)     |
# | inter 2 | $HOME/.bashrc       | every bash/Xterm, avoid output, non-login |
# | login 1 | /etc/environment    | System-wide environment pam_env.conf(5)   |
# | login 2 | ~/.pam_environment  | Session-wide environment pam_env.conf(5)  |
# | logout  | $HOME/.bash_logout  | executed on logout, think clean up        |
# |  kde    | /etc/kde/env/*      | upon sddm startup                         |
# |   X     | /etc/X11/Xsession.d | old X11 spec for X statup scripts, fonts  |
# |   X     | ~/.xinitrc          | X startup                                 |
# | gnome   | /etc/xdg/autostart  | X spec for startup files, XDG_CONFIG_DIRS |
# |  kde    | ~/.config/plasma-workspace/env | ~/.config/plasma-workspace/env |
# |    | for more info | http://wiki.bash-hackers.org/scripting/bashbehaviour |
# | sed     | remove new lines    | sed -e':a;N;$!ba;s/\n/ /g'                |
# | gnome   | ~/.config/autostart/* | set echo Hidden=true to disable /etc/*  |
#
#
#
#
#
# Above reserved for Helpy function

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
#if [ -x /usr/bin/gpg-agent ] && [ -z "$GPG_AGENT_INFO" ]; then
#  eval `gpg-agent --daemon`
#fi
