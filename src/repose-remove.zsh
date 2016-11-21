#!/usr/bin/zsh -f
# vim: ft=zsh sw=2 sts=2 et fdm=marker cms=\ #\ %s

# Copyright (C) 2016 SUSE LLC
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

declare -gr cmdname=$0:t

declare -gr cmdhelp=$'
usage: #c -h | --help | [-n] HOST... -- REPA...
Remove matching repositories
  Options:
    -h                    Display this message
    --help                Display full help
    -n, --print           Display, do not perform destructive commands
    -v, --verbose         Enable verbose mode for ssh|scp commands

  Operands:
    HOST                  Machine to operate on
    REPA                  Repository pattern
'

. ${REPOSE_PRELUDE:-@preludedir@/repose.prelude.zsh} || exit 2


function do-remove # {{{
{
  local h=$1 rn=$2 ru=$3; shift 3
  local -a repas; repas=("$@")

  [[ $rn == ${(j:|:)~repas} ]] || return 0

  rh-repo-remove $h $rn $ru
} # }}}

function rh-repo-remove # {{{
{
  run-in $1 zypper -n rr $3
} # }}}

main-hosts-repas "$@"
