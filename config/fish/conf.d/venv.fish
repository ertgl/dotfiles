if status is-interactive; and test -e .venv/bin/activate.fish
    # @fish-lsp-disable-next-line 1004
    source .venv/bin/activate.fish
end

function on_fish_postexec_maybe_activate_venv --on-event fish_postexec
    if not status is-interactive
        return
    end

    set -lu absolute_path (utils_parse_realrealpath_from_cd_command $argv[1])
    set -lu parse_status $status

    if test $parse_status -ne 0
        return
    end

    if test -e .venv/bin/activate.fish
        # @fish-lsp-disable-next-line 1004
        source .venv/bin/activate.fish
    end
end

function on_fish_preexec_maybe_deactivate_venv --on-event fish_preexec
    if not status is-interactive
        return
    end

    set -lu absolute_path (utils_parse_realrealpath_from_cd_command $argv[1])
    set -lu parse_status $status

    if test $parse_status -ne 0
        return
    end

    if string match -e -q "$PWD" "$absolute_path"
        return
    end

    if type -q deactivate
        deactivate
    end
end
