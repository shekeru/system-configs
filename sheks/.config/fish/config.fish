# SSH-Agent
if test -z (pgrep ssh-agent)
  eval (ssh-agent -c | sed 's/^echo/#echo/')
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end
# Colors
set fish_color_normal c5c8c6
set fish_color_command 2fa3e9
set fish_color_quote 5d9904
set fish_color_redirection ddc544
set fish_color_end d19a66
set fish_color_error cc665c --bold
set fish_color_operator 00a6b2
set fish_color_param 88d971
set fish_color_comment 990000
# Extra
set fish_color_match ff00ff
set fish_color_search_match eaf074
set fish_color_cwd d19a66
set fish_color_autosuggestion 3e4249
set fish_color_user 2fa3e9
set fish_color_host 88d971
set fish_color_cancel e06c75
# Searches
set fish_pager_color_progress db5eba --bold
set fish_pager_color_prefix white --bold --underline
set fish_pager_color_description f0d774
# Misc
set fish_color_escape 00a6b2
set fish_color_valid_path --underline
