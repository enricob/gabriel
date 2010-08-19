#!bash
#
# gabriel.bash
# Bash completion for god

__god_commands='start stop restart monitor unmonitor remove status signal load quit terminate check'

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
    start|stop|restart|monitor|unmonitor|remove|status|signal)
      local tasks="$(__god_task_group_names)"
      COMPREPLY=( $(compgen -W "${tasks}" -- ${cur}) )
      return 0
      ;;
    load)
      COMPREPLY=( $(compgen -A file -- ${cur}) )
      return 0
      ;;
    *)
    ;;
  esac

  COMPREPLY=( $(compgen -W "${__god_commands}" -- ${cur}) )
  return 0
}
complete -F _god god
