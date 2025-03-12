function y --wraps=yazi
    env FZF_DEFAULT_OPTS="--preview 'bat -n --color=always {}'" yazi $argv
end
