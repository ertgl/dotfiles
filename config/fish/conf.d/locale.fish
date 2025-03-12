if test -z "$LANGUAGE"
    set -Ux LANGUAGE "en_US:en"
end

if test -z "$LANG"
    set -Ux LANG ""
end

if test -z "$LC_COLLATE"
    set -Ux LC_COLLATE C
end

if test -z "$LC_CTYPE"
    set -Ux LC_CTYPE UTF-8
end

if test -z "$LC__FASTMSG"
    set -Ux LC__FASTMSG true
end

if test -z "$LC_MESSAGES"
    set -Ux LC_MESSAGES C
end

if test -z "$LC_MONETARY"
    set -Ux LC_MONETARY C
end

if test -z "$LC_NUMERIC"
    set -Ux LC_NUMERIC C
end

if test -z "$LC_TIME"
    set -Ux LC_TIME C
end

if test -z "$LC_ALL"
    set -Ux LC_ALL ""
end
