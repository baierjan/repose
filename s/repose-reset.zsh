#!/usr/bin/zsh -f
# vim: ft=zsh sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr cmdname=$0:t

declare -gr cmdhelp=$'
usage: #c -h | --help | [-n] HOST... [-- REPA...]
Remove stray repositories
  Options:
    -h                    Display this message
    --help                Display full help
    -n,--print            Display, do not perform destructive commands

  Operands:
    HOST                  Machine to operate on
    REPA                  Repository to whitelist
'

. ${REPOSE_PRELUDE:-@preludedir@/repose.prelude.zsh} || exit 2

function $cmdname-main # {{{
{
  local -a options; options=(
    h help
    n print
  )
  local print
  local on oa
  local -i oi=0
  while haveopt oi on oa $=options -- "$@"; do
    case $on in
    h | help      ) display-help $on ;;
    n | print     ) print=print ;;
    *             ) reject-misuse -$oa ;;
    esac
  done; shift $oi

  (( $# )) || reject-misuse

  local -i seppos="$@[(i)--]"
  local -a hosts; hosts=("$@[1,$((seppos - 1))]")
  local -a repas; repas=("$@[$((seppos + 1)),-1]")

  local REPLY
  local -a reply parts products
  local h p rn ru
  local -i i

  for ((i = 1; i <= $#repas; ++i)); do
    fixup-repa $repas[$i]
    repas[$i]=$REPLY
  done

  for h in $hosts; do
    o rh-list-products $h
    products=($reply)
    for ((i = 1; i <= $#products; ++i)); do
      p=$products[$i]
      parts=("${(@s.:.)p}")
      parts[3]=('*')
      products[$i]="${(@j.:.)parts}"
    done
    o rh-list-repos $h
    for rn ru in "${(@)reply}"; do
      [[ $rn == ${(j:|:)~products} ]] && continue
      [[ $rn == ${(j:|:)~repas} ]] && continue
      o $print ssh -n -o BatchMode=yes $h "zypper -n rr $ru"
    done
  done
} # }}}

$cmdname-main "$@"
