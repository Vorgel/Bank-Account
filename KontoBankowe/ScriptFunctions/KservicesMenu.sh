#!/bin/bash

source $(dirname $0)/cFunctionalities.sh # 1,3,4
source $(dirname $0)/installments.sh # 5
source $(dirname $0)/planned_payement.sh #2
source $(dirname $0)/documents.sh # 6
source $(dirname $0)/certificates.sh # 7
source $(dirname $0)/top_up.sh # 8
source $(dirname $0)/currency_exchange.sh # 9
source $(dirname $0)/globalVariables.sh
source $(dirname $0)/globalVariablesFunctions.sh

function greetingServices()
{	
    clear
    echo "Menu | Services"
    echo "1. Recipients" 
    echo "2. Scheduled payments"
    echo "3. Standing orders"
    echo "4. Saving goals" 
    echo "5. Installments "
    echo "6. Documents"
    echo "7. Certificates" 
    echo "8. Top-up" 
    echo "9. Currency exchange" 
    echo "Press desired option number in order to continue or press R in order to return..."
}

function menuServices()
{
    until [ "$choice" == "r" ] || [ "$choice" == "R" ]
    do

        greetingServices
        local choiceFormat='^([1-9]|r)$'    
        local choice
        read -rsn1 choice

        if ! [[ "$choice" =~ ^([1-9]|r)$ ]]
        then
            until [[ "$choice" =~ ^([1-9]|r)$ ]]
            do
                greetingServices
                read -rsn1 choice
            done
        fi

        case "$choice" in
        "1") cRecipientsFunctionality ;;
        "2") which ;;
        "3") cStandingOrdersFunctionality ;;
        "4") cSavingsAccountFunctionality ;;
        "5") ichanging ;;
        "6") dchanging ;;
        "7") ccchanging ;;
        "8") tchoose ;;
        "9") Kexchange $balance;;
        "r") return ;;
        esac

    done
}
