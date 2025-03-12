if test -z "$OMF_PATH"
    if test -z "$XDG_DATA_HOME"
        set -Ux OMF_PATH ~/.local/share/omf
    else
        set -Ux OMF_PATH $XDG_DATA_HOME/omf
    end
end

 source $OMF_PATH/init.fish
