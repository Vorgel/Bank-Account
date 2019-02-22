#!/bin/bash

function mWriteDataToTerminal
{
    touch terminals_in_area.txt
    local terminal=3

    local -a terminalAdress=("ul.Karmelicka_32" 'ul.Miodowa_11' 'ul.Szlak_2' );
    
    echo "Detected $terminal in the area" >> terminals_in_area.txt

    for i in ${terminalAdress[*]}
    do 
        printf "%s\n" "$i" >> terminals_in_area.txt
    done
}

function mShowTerminalsInTheArea()
{
    mWriteDataToTerminal
	
    local txtName="terminals_in_area.txt"     

    if [ -s $txtName ]
    then 
        if [ `whoami`=$USER ]
        then
            clear
            cat $txtName
        else 
            echo "You must be root to do that"
        fi
    else
        echo "cannot read There might be no credits added or file doesn't exists"
    fi
sleep 5
}
