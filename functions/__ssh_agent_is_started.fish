function __ssh_agent_is_started -d "check if ssh agent is already started"
  if [ -S "$agent" ]
    echo -e "agent socket already exists.\nReuse the running agent socket and reinitialize SSH_AUTH_SOCKET."
    set -gx SSH_AUTH_SOCK $agent
    return 0
  end

  if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
    source $SSH_ENV > /dev/null
  end

  if begin; test -z "$SSH_AGENT_PID"; and test -z "$SSH_CONNECTION"; end
    return 1
  end

  ssh-add -l > /dev/null 2>&1
  if test $status -eq 2
    return 1
  end
end

