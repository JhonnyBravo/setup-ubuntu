#!/bin/bash

script_name=$(basename "$0")

package="ssh"
g_flag=0
s_flag=0

function usage(){
cat <<_EOT_
NAME:
  ${script_name}

USAGE:
  ${script_name} [-g] [-s] [-h]

DESCRIPTION:
  manage ssh client configuration

OPTIONS:
  -g  copy ~/.ssh/config to ~/Templates/ssh/config
  -s  copy ~/Templates/ssh/config to ~/.ssh/config
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
  if [ -f ~/.ssh/config ]; then
    if [ ! -d ~/Templates/ssh ]; then
      mkdir -p ~/Templates/ssh
    fi

    cp ~/.ssh/config ~/Templates/ssh/config
  else
    echo "not found ~/.ssh/config"
    exit 1
  fi
elif [ $s_flag -eq 1 ]; then
  if [ -f ~/Templates/ssh/config ]; then
    cp ~/Templates/ssh/config ~/.ssh/config
  else
    echo "not found ~/Templates/ssh/config"
    exit 1
  fi
fi
