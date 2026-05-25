function lulu_datetime_anonymize
    set -l input

    if test (count $argv) -gt 0
        set input "$argv"
    else
        if isatty stdin
            echo "Usage: lulu_datetime_anonymize <datetime_string> OR stream text via stdin" >&2
            return 1
        end

        read -z input
    end

    set -l datetime_regex '(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\+\d{4})'

    echo "$input" | string replace -a -r $datetime_regex "1970-01-01T00:00:00+0000"
end
