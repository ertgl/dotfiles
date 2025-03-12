function mkcd --wraps=mk
    mkdir $argv
    cd $argv[-1]
end
