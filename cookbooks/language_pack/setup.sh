#!/bin/bash

script_name=$(basename "$0")

package="language-pack-ja manpages-ja manpages-ja-dev"
i_flag=0
u_flag=0

function usage(){
cat <<_EOT_
NAME:
  ${script_name}

USAGE:
  ${script_name} [-i] [-u] [-h]

DESCRIPTION:
  install / uninstall ${package}

OPTIONS:
  -i  install ${package}
  -u  uninstall ${package}
  -h  show help
_EOT_
exit 1
}

while getopts "iuh" option
do
  case $option in
  i)
    i_flag=1
    ;;
  u)
    u_flag=1
    ;;
  h)
    usage
    ;;
  \?)
    usage
    ;;
  esac
done

if [ $i_flag -eq 1 ]; then
  # shellcheck disable=SC2086
  apt-get install ${package}
  update-locale LANG=ja_JP.UTF8
  dpkg-reconfigure tzdata
elif [ $u_flag -eq 1 ]; then
  # shellcheck disable=SC2086
  apt-get purge ${package}
fi
