set -g fish_greeting ""

function starship_transient_prompt_func
  starship module character
end
starship init fish | source
enable_transience

zoxide init fish | source

