function urandom_base64 -a bytes
    if test -z "$bytes"
        set bytes 32
    end

    head -c $bytes /dev/urandom | base64
end
