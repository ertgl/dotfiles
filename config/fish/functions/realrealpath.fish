function realrealpath -a path -a command
    set -lu absolute_path ""

    if test -z "$command"
        set command realpath
    end

    if test -z "$path"
        set absolute_path (eval $command ~)
    else
        if string match -qr '^\s*\-\s*$' $path
            if string match -qr '^\s*(?<dirpath>.+)\s*$' $dirpath
                set absolute_path $dirpath
            else
                set absolute_path $PWD
            end
        else
            set absolute_path (eval $command $path)
        end
    end

    if test -z "$absolute_path"
        return 1
    end

    echo $absolute_path

    return 0
end
