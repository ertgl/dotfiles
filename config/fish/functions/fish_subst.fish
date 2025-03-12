function fish_subst -a command --description "Run a command with fish" --wraps fish
    echo $command | fish /dev/stdin $argv
end
