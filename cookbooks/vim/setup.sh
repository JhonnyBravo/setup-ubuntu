#!/bin/bash

script_name=$(basename "$0")

package="vim"
g_flag=0
s_flag=0

function usage(){
cat <<_EOT_
NAME:
  ${script_name}

USAGE:
  ${script_name} [-g] [-s] [-h]

DESCRIPTION:
  manage .vimrc

OPTIONS:
  -g  copy ~/.vimrc to ~/Templates/vim/.vimrc
  -s  copy ~/Templates/vim/.vimrc to ~/.vimrc
  -h  show help
_EOT_
exit 1
}

while getopts "gsh" option
do
  case $option in
  g)
    g_flag=1
    ;;
  s)
    s_flag=1
    ;;
  h)
    usage
    ;;
  \?)
    usage
    ;;
  esac
done

if [ $g_flag -eq 1 ]; then
  if [ -f ~/.vimrc ]; then
    if [ ! -d ~/Templates/vim ]; then
      mkdir -p ~/Templates/vim
    fi

    cp ~/.vimrc ~/Templates/vim/.vimrc
  else
    echo "not found ~/.vimrc"
    exit 1
  fi
elif [ $s_flag -eq 1 ]; then
  if [ -f ~/Templates/vim/.vimrc ]; then
    cp ~/Templates/vim/.vimrc ~/.vimrc 
  else
    echo "not found ~/Templates/vim/.vimrc"
    exit 1
  fi
fi
