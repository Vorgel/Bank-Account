#!/bin/bash

function mShowInsurence()
{ 
    local showFromTxt="insurences.txt"

    if [ -s $showFromTxt ]
    then 
        if [ `whoami`=$USER ]
        then
            clear
            cat $showFromTxt
        else 
            echo "You must be root to do that"
        fi
    else
        echo "cannot read There might be no cards added or file doesn't exists"
    fi
}
#usun wez funkcje z cards_tel_pa..
function mYesNo()
{
    echo "1) Back to sub-menu"
    echo "2) Back to menu"
}

#usun wez funkcje z cards_tel_pa..
function mmValidatePick
{
    local pic=$1

    until  [[ $pic -gt 0 ]] && [[ $pic =~ $re ]] && [[ $pic -lt 3 ]]
    do 
        echo "Expected number from 1 to 3"
        echo "Enter again"
        read pic
        clear 
    done 
}




function Insurences()
{
    touch insurences.txt
    local -a insurences=("telefon" "dom" "dziecko" "rower" "samochod" "zwierze" "lodz" "piekarnik" "komputer" "motor") 
    local -a insPrize=("50" "450" "100" "23" "1000" "300" "21" "222" "100" "50")
    local c=1 
    local choice

while [ 1 ] 
do

    echo "1) Add insurence"
    echo "2) Show insurence "

    local pick 
    read pick 

    mmValidatePick $pick 

    case $pick in 

        "1")
        echo "Avaible insurences: "

        for i in ${insurences[*]}
        do 
            echo "$c) Ubezpieczenie na $i"
            let c=c+1
        done 

        echo "Pick from 1 to 10"

        local pik
        read pik

        if [ -z ${insurences[$pik-1]} ] 
        then 
            echo "You cant pick this kind of insurence Probaly already taken"
            echo "Pick again "
            read pik 
        fi 

        until  [[ $pik -gt 0 ]] && [[ $pik =~ $re ]] && [[ $pik -lt 11 ]]
        do 
            echo "Expected number from 1 to 10"
            echo "Enter again"
            read pik
            clear 
        done 

        clear 
        echo "Insurence type: Ubezpieczenie na ${insurences[$pik-1]}"
        echo "Cost: ${insPrize[$pik-1]}"
        echo "Do you want to take this insurence?"

        mYesNo

        local smh
        read smh
        mmValidatePick $smh 

        if [ $smh -eq 1 ]
        then 
            echo "how many months? You can take maximum 36 moths"
            local monthNumber
            read monthNumber
            

            until  [[ $monthNumber -gt 0 ]] && [[ $monthNumber =~ $re ]] && [[ $monthNumber -lt 37 ]]
            do 
                echo "Expected number from 1 to 36"
                echo "Enter again"
                read monthNumber
                clear 
            done 

            printf "%s\n" "Insurence type: Ubezpieczenie na ${insurences[$pik-1]} ">> insurences.txt
            printf "%s\n" "Cost per month  : ${insPrize[$pik-1]} ">> insurences.txt  
            printf "%s\n" "Insurence time: Ubezpieczenie na $monthNumber miesiecy ">> insurences.txt
            echo "#########################################" >> insurences.txt
            unset 'insurences[$pik-1]'
            c=1

            mYesNo

            read choice
                
            mmValidatePick $choice 

            if [ $choice -eq 1 ]
            then 
                echo "OK"
                clear 
            else 
                break 
            fi  
        fi    
                ;;
        "2")
            	mShowInsurence

                mYesNo

                read choice
                
                mmValidatePick $choice 

                if [ $choice -eq 1 ]
                then 
                    echo "OK"
                    clear 
                else 
                    break 
                fi 

                ;;
    esac
done           
}

