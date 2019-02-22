#!/bin/bash

function mValidateNumber()
{
    local number=$1
    local numberLength=$2
    local numberFormat="^[0-9]{$numberLength}$"

    if [[ "$number" =~ $numberFormat ]]
    then
        echo 1
    else
        echo 0
    fi
}

function mValidateWord
{
    local word=$1    
    local wordFormat='^[A-Z][a-z][a-z]+$'

    if [[ "$word" =~ $wordFormat ]]
    then
        echo 1
    else
        echo 0
    fi
}

function mShowFromTxtSecure()
{ 
    local showFromTxt="secure_cards_and_phones.txt"

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

function mDisplayChoice
{
    echo "1) Back to sub-menu"
    echo "2) Back to menu"
    
}

function mDisplayMenu()
{
    echo "Here you can order new card or boud your card with a phone"
    echo "1) Show cards bouded with a phone"
    echo "2) Add new card "
    echo "3) Bound telephone with a card"
}


function mValidatePick
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


function CardsAndTelPayments()
{
    local txtName="BASE_cards_and_phones.txt"
    local counter=0
    local -a arrOfCardNumbers=()
    local choice

    touch secure_cards_and_phones.txt

    while [ 1 ] 
    do 

    local tmp=${#arrOfCardNumbers[*]}
    mDisplayMenu

    local pickMe
    read pickMe
    clear

    until  [[ $pickMe -gt 0 ]] && [[ $pickMe =~ $re ]] && [[ $pickMe -lt 4 ]]
    do 
        echo "Expected number from 1 to 3"
        echo "Enter again"
        read pickMe
        clear 
    done 
    
    case $pickMe in 
        "1")    
                mShowFromTxtSecure

                mDisplayChoice

                read choice
                
                mValidatePick $choice 

                if [ $choice -eq 1 ]
                then 
                    echo "OK"
                    clear 
                else 
                    break 
                fi 


                ;;
        "2")    
                local cardNumber
                echo "Generating card number"

                cardNumber=$((( RANDOM % 99999999999 ) + 10000000000 )) 
                arrOfCardNumbers[$counter]=$cardNumber

                echo "Your new card has: $cardNumber"
                let counter=counter+1

                mDisplayChoice

                read choice
                
                mValidatePick $choice 

                if [ $choice -eq 1 ]
                then 
                    echo "OK"
                    clear 
                else 
                    break 
                fi 
            

                ;;
        "3")    
                echo "Bound card number with your phone"
                sleep 1
                clear 

                echo "Avaible cards: "

                for i in ${arrOfCardNumbers[*]}
                do 
                    printf "%s\n" $i 
                done 
			
		if [ $tmp -eq 0 ]
		then 
			echo "No cards added"
s			sleep 2
			return 
		fi 


                echo "Type in card number do you wanna bound"

                local typeCard
                read typeCard
                
                local flag2
                

                while [ 1 ]
                do     
                    local typeCardS=$(mValidateNumber $typeCard 11)
                    for ((i=0; i<$(($tmp+1)) ; i++))
                    do
                        if [ $typeCardS == 0 ] 
                        then
                                echo "Wrong format"
                                flag2=0
                                break   
                        elif [[ ${arrOfCardNumbers[$i]} -eq $typeCard ]]
                        then 
                                local flag=1
                        fi

                    done  
                   
                    if [[ $flag -eq 1 ]] 
                    then 
                        break
                    elif [[ $flag2 -eq 0 ]]
                    then
                        read typeCard
                    else 
                        echo "There is no such a card"
                        read typeCard
                    fi 
                done 

                echo "Enter your phone number to pair"

                local phoneNumber
                read phoneNumber
                
                while [ 1 ]
                do 
                    local phoneNumersS=$(mValidateNumber $phoneNumber 9)
                    if [ $phoneNumersS == 0 ]
                    then 
                        echo "Invalid format of phone number"
                        echo "Type again"
                        read phoneNumber
                    else 
                        break
                    fi
                done 

                local tempo=$(echo $typeCard | cut -c 6-)

                printf "%s\n" "Number Karty: ******$tempo " >> secure_cards_and_phones.txt
                printf "%s\n" "Przyporządkowany numer telefonu: $phoneNumber " >> secure_cards_and_phones.txt
                echo "########################################" >> secure_cards_and_phones.txt

                mDisplayChoice

                read choice
                
                mValidatePick $choice 

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

#Jak starczy czasu zadbaj o dodatkowa walidacje 
#ogólnie dziala wszystko dosc dobrze 
