
function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert -m insert \cc kill-whole-line force-repaint
    bind -m insert \cc kill-whole-line force-repaint
end

function fish_prompt
    fish_vi_prompt
end

fish_vi_cursor

set -x EDITOR vim
set -x VISUAL vim

