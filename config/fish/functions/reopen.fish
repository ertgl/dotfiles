function reopen -a app
    if test -z "$app"
        echo "Usage: reopen <app>" >&2
        return 1
    end

    quit "$app"
    open -a "$app"
end
