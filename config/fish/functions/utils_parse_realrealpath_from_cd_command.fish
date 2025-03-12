function utils_parse_realrealpath_from_cd_command -a cmd
    if not string match -qr '^\s*cd(?:\s+(?<path>[^\;]+))?\s*$' $cmd
        return 2
    end

    set -lu absolute_path (realrealpath "$path" 'path resolve')
    set -lu parse_status $status

    if test $parse_status -ne 0
        return 1
    end

    echo $absolute_path

    return $parse_status
end
