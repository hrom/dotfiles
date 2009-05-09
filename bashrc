  # .bashrc
# By Hicham Romane
# At 2009-05-04

###############################################################################
# profile
###############################################################################
enable_color_support()
{
  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
}

set_shell_prompt()
{
  clear
  echo -e "Welcome $USERNAME to $HOSTNAME"
  echo -e "Today is `date`"
  echo -e "Kernel is `uname -smr`"
  
  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
    xterm-color) color_prompt=yes;;
  esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  force_color_prompt=yes

  if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	    # We have color support; assume it's compliant with Ecma-48
	    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	    # a case would tend to support setf rather than setaf.)
	    color_prompt=yes
    else
	    color_prompt=
    fi
  fi

  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\[\033[0;31m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
}

make_a_long_history()
{
  export HISTSIZE=10000000
  export HISTCONTROL=ignoreboth
  shopt -s histappend
  export HISTIGNORE="&:ls:cd:ll:la:l.:pwd:exit:clear"
}

check_window_size_after_each_command()
{
  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize
}

use_lesspipe_for_nontext_files()
{
  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
}

set_environment()
{
  export  EDITOR=vim
  export  BROWSER=firefox

  # Create files as u=rwx, g=rx, o=rx
  umask 022

  check_window_size_after_each_command
  use_lesspipe_for_nontext_files
}

use_profile()
{
  enable_color_support
  set_shell_prompt
  make_a_long_history
  set_environment
}
###############################################################################
# aliases
###############################################################################
add_shortcuts()
{
  alias l='ls -lh'
  alias h='history'
  alias c='clear'
  alias v='vim'
  alias r='rm -vr'
  alias t='tail -n 50'
  alias g='egrep --color'
  alias x='exit'
  alias d='dict'
  export HISTIGNORE="l:h:c:$HISTIGNORE"
}

add_cd_aliases()
{
  alias home='cd ~'
  alias back='cd $OLDPWD'
  alias ..="cd .."
  alias ...="cd ../.."
  alias ....="cd ../../.."
  alias .....="cd ../../../.."
  alias ......="cd ../../../../.."
  export HISTIGNORE="home:back:..:...:....:.....:......:$HISTIGNORE"
}

add_ls_aliases()
{
  # Alias to multiple ls commands
  alias la='ls -Al'                 # show hidden files
  alias ll='ls -l --color=always'  # add colors and file type extensions
  alias lx='ls -lXB'                # sort by extension
  alias lk='ls -lSr'                # sort by size
  alias lc='ls -lcr'                # sort by change time
  alias lu='ls -lur'                # sort by access time
  alias lr='ls -lR'                 # recursive ls
  alias lt='ls -ltr'                # sort by date
  alias lm='ls -al |more'           # pipe through 'more'
  alias lsg='ls | grep'
  export HISTIGNORE="la:ll:lx:lk:lc:lu:lr:lt:lm:lsg:$HISTIGNORE"
}

add_interactivity_to_file_operations()
{
  alias cp='cp -i'
  alias rm='rm -i'
  alias mv='mv -i'
}

add_chmod_aliases()
{
  alias mx='chmod a+x'
  alias 000='chmod 000'
  alias 644='chmod 644'
  alias 755='chmod 755'
}

add_debian_package_management_aliases()
{
  alias acs='apt-cache search'
  alias acsh="apt-cache show"
  alias agi='apt-get install -y'
  alias agr='apt-get remove'
  alias agu='apt-get update'
  alias sagi='sudo apt-get install -y'
  alias sagr='sudo apt-get remove'
  alias sagu='sudo apt-get update'
}

add_ruby_gems_package_management_aliases()
{
  alias gemi='sudo gem install -y'
  alias gemr='sudo gem uninstall -y'
  alias gemu='sudo gem update'
}

add_ruby_on_rails_aliases()
{
  alias ss='./script/server'
  alias sc='./script/console'
  alias sg='./script/generate'
  alias sp='./script/plugin'
  alias sl='open firefox http://localhost:3000'
}

use_aliases()
{
  add_shortcuts
  add_cd_aliases
  add_ls_aliases
  add_interactivity_to_file_operations
  add_chmod_aliases
  add_debian_package_management_aliases
  add_ruby_gems_package_management_aliases
  add_ruby_on_rails_aliases
}

###############################################################################
# functions
###############################################################################
initialize_running_commands()
{
  use_profile
  use_aliases
}
# bootstrap all the above 
initialize_running_commands

# open a GUI app from CLI
open() 
{
  $1 >/dev/null 2>&1 &
}

# make a backup before editing a file
safeedit() 
{
  cp $1 $1.backup && vim $1
}

# find a file with a pattern in name:
ff() 
{ 
  find . -type f -iname '*'$*'*' -ls ; 
}

# grepping for processes matching a pattern
psg() 
{
  if [ ! -z $1 ] ; then
    echo "Grepping for processes matching $1..."
    ps aux | grep -v grep | grep $1 --color
  else
    echo "!! Need name to grep for"
  fi
}

# makes directory then moves into it
mkcdr() 
{
	mkdir -p -v $1
	cd $1
}

# processes
# processes sorted by cpu usage
ps_cpu()
{
  ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu \
    | sed '/^ 0.0 /d' | pr -TW$COLUMNS
}

# processes sorted by memory usage
ps_mem()
{
  ps -e -orss=,args= | sort -b -k1,1n | pr -TW$COLUMNS
}

# user processes
ps_user() 
{ 
  ps aux | grep "^$USER" | pr -TW$COLUMNS; 
}

# extract files from various types of acrhives
extract() 
{
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2|*.tbz2)  tar xjf "$1"    ;;
      *.tar.gz|*.tgz)    tar xzf "$1"    ;;
      *.bz2)             bunzip2 "$1"    ;;
      *.rar)             rar x "$1"      ;;
      *.gz)              gunzip "$1"     ;;
      *.tar)             tar xf "$1"     ;;
      *.7z)              7zr x "$1"      ;;
      *.zip|*.xpi|*.jar) unzip "$1"      ;;
      *.Z)               uncompress "$1" ;;
      *)                 echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# roll files to various types of acrhives
roll() 
{
  if [ "$#" -ne 0 ] ; then
    FILE="$1"
    case "$FILE" in
      *.tar.bz2|*.tbz2) shift && tar cjf "$FILE" $* ;;
      *.tar.gz|*.tgz)   shift && tar czf "$FILE" $* ;;
      *.tar)            shift && tar cf "$FILE" $* ;;
      *.zip)            shift && zip "$FILE" $* ;;
      *.rar)            shift && rar "$FILE" $* ;;
      *.7z)             shift && 7zr a "$FILE" $* ;;
      *)                echo "'$1' cannot be rolled via roll()" ;;
    esac
  else
    echo "usage: roll [file] [contents]"
  fi
}

# a calculator powered by bc, the arbitrary precision calculator language
calc() 
{
  echo "$*" | bc -l
}

# recursively fix dir/file permissions on a given directory
fix_permissions() 
{
  if [ -d $1 ]; then 
    find $1 -type d -exec chmod 755 {} \;
    find $1 -type f -exec chmod 644 {} \;
  else
    echo "$1 is not a directory."
  fi
}

# shutdown after a number of minutes
zzz()
{
  if [ ! -z $1 ] ; then
    sudo shutdown -h +$1
  else
    echo "!! Need number of minutes to shutdown after"
  fi
}

# controls apache and mysql servers
lamp()
{
  case $1 in
    start)
      echo "Starting the LAMP server.."
      sudo /etc/init.d/apache2 start
      sudo /etc/init.d/mysql start
      echo "LAMP server started."
    ;;
    stop)
      echo "Stoping the LAMP server.."
      sudo /etc/init.d/apache2 stop
      sudo /etc/init.d/mysql stop
      echo "LAMP server stopped."
    ;;
    restart)
      echo "Restarting the LAMP server.."
      sudo /etc/init.d/apache2 restart
      sudo /etc/init.d/mysql restart
      echo "LAMP server re@:wstarted."
    ;;
    *)
      echo "Usage: $0 {start|stop|restart}"
      exit 1
    ;;
  esac
}

# controls a pppoe ueagle-atm adsl connection
mynara()
{
  case $1 in
    start)
      sudo /etc/init.d/mynara start
    ;;
    stop)
      sudo /etc/init.d/mynara stop
    ;;
    restart)
      sudo /etc/init.d/mynara restart
    ;;
    *)
      echo "Usage: $0 {start|stop|restart}"
      exit 1
    ;;
  esac
}

