function mkcd --wraps=mkdir
    mkdir $argv
    cd $argv[-1]
end
