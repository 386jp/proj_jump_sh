#!/usr/bin/env zsh

function pj_comp() {
    cmds=( ${(uf)"$(while read row; do echo "`echo -n ${row} | cut -d , -f 1,2 | sed -e 's/,/\[/g'`]";done < $HOME/.proj_jump/proj_list)"} )
    _values $cmds 'edit_proj[Edit Project Directory Definition]'
}

function pj() {

    if [ -z "$1" ]; then
        cd $HOME
        return 0
    fi

    if [ 'edit_proj' = $1 ]; then
        nano $HOME/.proj_jump/proj_list
        return 0
    fi

    while read row; do
        p_name=`echo ${row} | cut -d , -f 1`
        if [ $p_name = $1 ]; then
            cd $HOME/`echo ${row} | cut -d , -f 3`
            return 0
        fi
    done < $HOME/.proj_jump/proj_list

}

compdef pj_comp pj
