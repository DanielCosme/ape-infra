set fish_greeting

fish_vi_key_bindings
fish_user_key_bindings

function history
    builtin history --show-time='%F %T '
end

abbr -a gs git status
abbr -a ga git add
abbr -a gc git commit
abbr -a gcm git commit -m
