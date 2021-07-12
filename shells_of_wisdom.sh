#!/bin/bash

################################################################################
# shells of "wisdom" !
################################################################################

alias _log='builtin echo [$0] [$$:$?] [$( date +"%T" )]'
alias echo='1>&2 builtin echo'

alias null_1='1>/dev/null'
alias null_2='2>/dev/null'
alias null='null_1 | null_2'

################################################################################
# wrappers around useful lines of code
################################################################################

function in_place_uniq() {
  local path=${2:-$1}
  local extra_options=${1:-}
  if [ ! -r "$path" ] ; then return -1; fi

  sort -u $extra_options "$path" > "$path.swap"
  mv -f "$path.swap" "$path"

  return 0
}

function exec_eXternal() {
  if [ -z "$@" ]; then return -1; fi

  echo "[INFO] eXternal command: $@"
  $@
  echo "[INFO] Exit code: $?"
  return $?
}

# some one-liners for data manipulation

function _csv_field() {
  local i=${1}-1 ; shift ; local a=(${@//\;/ }) ; builtin echo "${a[$i]}"
}

function _date_from_mongoId() {
  date -d @$((0x$(echo "${1:-$(printf "%08x" $(date +%s))}" | cut -c1-8)))
}

