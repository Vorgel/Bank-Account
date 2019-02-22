#!/bin/bash

function ShowInfoCreditAndLoans()
{
while [ 1 ]
do
    local txtName="creditInfo.txt"     

    if [ -s $txtName ]
    then 
        if [ `whoami`=$USER ]
        then
            cat creditInfo.txt
        else 
            echo "You must be root to do that"
        fi
    else
        echo "cannot read There might be no credits added or file doesn't exists"
    fi


    echo "Press 1 to back "
    local back 
    read back 

    until [[ $back -gt 0 ]] && [[ $back -lt 2 ]]  
    do 
        echo "Expected number 1"
        echo "Pick again"
        read back 
    done 

    if [ $back -eq 1  ]
    then 
        break 
    fi 
done 
}

#zalezne od funkcji loans
#nazwa pliku przechowujaca kredyty 