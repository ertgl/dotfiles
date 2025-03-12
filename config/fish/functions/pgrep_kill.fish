function pgrep_kill -a process_name -a signal_name
    if test -z $process_name
        echo "Usage: pgrep_kill <process_name> <signal_name>"
        return 1
    end

    if test -z $signal_name
        echo "Usage: pgrep_kill <process_name> <signal_name>"
        return 2
    end

    pgrep $process_name | xargs kill -s $signal_name 2>/dev/null
end
