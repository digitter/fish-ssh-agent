function __ssh_agent_start -d "start a new ssh agent"
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  chmod 600 $SSH_ENV
  source $SSH_ENV > /dev/null

  set agent "$HOME/.ssh/agent_tmp"
  ln -snf "$SSH_AUTH_SOCK" $agent && set -gx SSH_AUTH_SOCK $agent
end

