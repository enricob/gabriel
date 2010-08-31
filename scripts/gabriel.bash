#!/usr/bin/env bash
#
# gabriel.bash
# Bash completion for god

__god_commands='start stop restart monitor unmonitor remove status signal load quit terminate check'

__god_options_long='--config-file --port --auto-bind --pid --log --no-daemonize --version --log-level --no-syslog --attach --no-events --bleakhouse'
__god_options_short='-c -p -b -P -l -D -v -V'
__god_options="${__god_options_long} ${__god_options_short}"

__god_log_levels="debug info warn error fatal"

__god_task_group_names() {
  god status > /dev/null
  if [ "$?" -eq "0" ]; then
    god status | awk '{ print $1 }' | tr -d \\n | sed 's/:/ /g'
  else
    echo ""
  fi
}

_god() {
  local cur prev
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  case "${prev}" in
    start|stop|restart|monitor|unmonitor|remove|status)
      local tasks="$(__god_task_group_names)"
      COMPREPLY=( $(compgen -W "${tasks}" -- ${cur}) )
      return 0
      ;;
    signal)
      local tasks="$(__god_task_group_names)"
      COMPREPLY=( $(compgen -W "${tasks}" -A signal -- ${cur}) )
      return 0
      ;;
    --log-level)
      COMPREPLY=( $(compgen -W "${__god_log_levels}" -- ${cur}) )
      return 0
      ;;
    god)
      COMPREPLY=( $(compgen -W "${__god_commands} ${__god_options}" -- ${cur}) )
      return 0
      ;;
    *)
    ;;
  esac
}
complete -o bashdefault -o default -o nospace -F _god god
