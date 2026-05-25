function quit -a app
    if test -z "$app"
        echo "Usage: quit <app>" >&2
        return 1
    end

    killall "$app"
end
