if test -f /opt/homebrew/bin/tree
    function tree --wraps=/opt/homebrew/bin/tree
        /opt/homebrew/bin/tree -C --dirsfirst $argv
    end
end
