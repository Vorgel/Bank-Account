#!/bin/bash

source $(dirname $0)/standingOrders.sh

function cGenerateCode
{
    local code=$(shuf -i100000-999999 -n1)  
    touch $(dirname $0)/authenticationCode.txt
    echo $code > $(dirname $0)/authenticationCode.txt
}

function cAuthentication
{
    clear
    local code=$(cat "$(dirname $0)/authenticationCode.txt")
    
    local userInput
    read -p "Enter authentication code here (you can find it in a file called authenticationCode.txt in the same directory as the script): " userInput
    if [ "$userInput" != $code ]
    then
        echo "Please try again."
        sleep 3
        cAuthentication
    fi
}

function cValidateTransfer
{
    clear
    echo "You are transfering" $1 "to" $2":" $3"," $4"." >&2
    echo "Press U if you want to undo it or press C if you want to continue. " >&2
    
    local option
    read -rsn1 option

    if [ "$option" == "u" ] || [ "$option" == "U" ]
    then
        return 0
    elif [ "$option" == "c" ] || [ "$option" == "C" ]
    then
        return 1
    else
        cValidateTransfer
    fi
}

function cGetCurrency
{
    clear
    local index=0
    local -a currencies=()

    while read -r line
    do
        currencies[$index]="$line"
        let index++
    done < $(dirname $0)/currency_exchange.txt

    for (( i=0; i<$index-1; i++ ))
    do
        echo $(($i+1))"." ${currencies[$i]}
    done

    local option
    echo -n "Type in desired currency number in order to continue or press R in order to return to the previous page: "
    read -rsn1 option
    local optionFormat='^([1-9]|r|R)$'

    if [[ "$option" =~ $optionFormat ]]; 
    then 
        if [ "$option" == "r" ] || [ "$option" == "R" ]; then return 0; fi
        echo ""
        return $option
    else
        cGetCurrency
    fi
}

function cCanYouTransfer
{
    local balanceAfterTransfer=$(($balance-$1))

    if [ $balanceAfterTransfer -lt 0 ]
    then
        echo 0
    else
        echo 1
    fi
}