#!/bin/bash

source $(dirname $0)/loans.sh
source $(dirname $0)/cards_and_tel_payments.sh
source $(dirname $0)/loans_and_credits.sh
source $(dirname $0)/terminals_in_area.sh
source $(dirname $0)/retirement.sh
source $(dirname $0)/insurence.sh
source $(dirname $0)/leasing.sh
source $(dirname $0)/zus.sh

function MenuOffersDisplay()
{
    clear
    echo "Menu | Offers"
    echo "1. Savings"   
    echo "2. Loans"  
    echo "3. Credits And Loans"  
    echo "4. Blik"  
    echo "5. Retirements" 
    echo "6. Insurence" 
    echo "7. Settlement with ZUS"
    echo "8. Leasing"
    echo "9. Terminals in area" 
    echo "10. Back"
    echo -n "Type in desired option number in order to continue: "
}

function MenuOffer()
{
    local snumber
    read snumber
  
    until [[ $snumber -gt 0 ]] && [[ $snumber -lt 12 ]]
    do 
        echo "Wrong format exptected 1-10"
        echo "Pick again "
        read snumber
    done 

  
  case "$snumber" in
    1)
        cSavingsAccountFunctionality
        ;;
    2)
        Loans
        ;;
    3)
        ShowInfoCreditAndLoans
        ;;
    4)
        CardsAndTelPayments
        ;;
    5)
        Kretirement
        ;;
    6)
        Insurences
        ;;
    7)
        cTransferToZus
        ;;
    8)
        Leasing 
  	    ;;
    9)
        mShowTerminalsInTheArea
        ;;
    10) 
        return
        ;;
  esac

  clear 
  MenuOffersDisplay
  MenuOffer
}