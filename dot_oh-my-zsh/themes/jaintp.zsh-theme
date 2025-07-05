# Based on the amazing duelij zsh theme.

PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;34m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;33m%}%!%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─[%{\e[1;35m%}$%{\e[0;34m%}%B]%{\e[0m%}%b '
RPROMPT='[%*]'
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

# Add Git and Virtual Environment status
function update_prompt() {
  local git_branch=""
  local venv=""
  local combined_info=""

  # Check for Git branch
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    git_branch="$(git branch --show-current 2>/dev/null)"
    git_branch="%F{blue}$git_branch%f"
  fi

  # Check for Python Virtual Environment
  if [[ -n $VIRTUAL_ENV ]]; then
    venv="%F{green}$(basename $VIRTUAL_ENV)%f"
  fi

  # Combine Git and Virtual Environment info
  if [[ -n $git_branch && -n $venv ]]; then
    combined_info=" - [$git_branch - $venv]"
  elif [[ -n $git_branch ]]; then
    combined_info=" - [$git_branch]"
  elif [[ -n $venv ]]; then
    combined_info=" - [$venv]"
  fi

  PROMPT=$'%F{blue}%B┌─[%b%f%F{green}%n%F{blue}@%f%F{cyan}%m%F{blue}%B]%b%f - %B[%F{white}%~%F{blue}]%b'"$combined_info - [%F{yellow}%!%F{blue}]%f"$'\n%F{blue}%B└─[%F{magenta}$%F{blue}]%f%b '
}

# Trigger prompt update
autoload -Uz add-zsh-hook
add-zsh-hook precmd update_prompt


# Trigger prompt update
autoload -Uz add-zsh-hook
add-zsh-hook precmd update_prompt
