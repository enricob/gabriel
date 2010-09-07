#!/usr/bin/env bash
#
# gabriel.bash
# Bash completion for god

__god_commands='start stop restart monitor unmonitor remove status signal load quit terminate check'

__god_options_long='--config-file --port --auto-bind --pid --log --no-daemonize --version --log-level --no-syslog --attach --no-events --bleakhouse'
__god_options_short='-c -p -b -P -l -D -v -V'
__god_options="${__god_options_long} ${__god_options_short}"

__god_log_levels="debug info warn error fatal"

__god_tasks_and_groups() {
  god status > /dev/null
  if [ "$?" -eq "0" ]; then
    god status | awk '{ print $1 }' | tr -d \\n | sed 's/:/ /g'
  else
    echo ""
  fi
}

__god_tasks() {
  god status > /dev/null
  if [ "$?" -eq "0" ]; then
    god status | grep "  " | awk '{ print $1 }' | tr -d \\n | sed 's/:/ /g'
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
      local tasks_and_groups="$(__god_tasks_and_groups)"
      COMPREPLY=( $(compgen -W "${tasks_and_groups}" -- ${cur}) )
      return 0
      ;;
    signal)
      local tasks_and_groups="$(__god_tasks_and_groups)"
      COMPREPLY=( $(compgen -W "${tasks_and_groups}" -A signal -- ${cur}) )
      return 0
      ;;
    log)
      local tasks="$(__god_tasks)"
      COMPREPLY=( $(compgen -W "${tasks}" -- ${cur}) )
      return 0
      ;;
    --log-level)
      COMPREPLY=( $(compgen -W "${__god_log_levels}" -- ${cur}) )
      return 0
      ;;
    load|-P|-l|-c|--config-file)
      # Use default completions
      ;;
    god)
      COMPREPLY=( $(compgen -W "${__god_commands} ${__god_options}" -- ${cur}) )
      return 0
      ;;
    *)
      COMPREPLY=( $(compgen -W "${__god_options}" -- ${cur}) )
      return 0
      ;;
  esac
}
complete -o bashdefault -o default -o nospace -F _god god