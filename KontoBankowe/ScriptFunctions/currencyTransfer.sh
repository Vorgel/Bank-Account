#!/bin/bash

source $(dirname $0)/globalVariablesFunctions.sh 
source $(dirname $0)/globalVariables.sh
source $(dirname $0)/usefulFunctions.sh
source $(dirname $0)/transfersFunctions.sh
source $(dirname $0)/savingsAccount.sh
source $(dirname $0)/transfersHistory.sh
source $(dirname $0)/currency_exchange.sh

#Takes "Person"/"Firm" as an argument
function cCurrencyManualTransfer
{
    clear

    if [ "$1" == "Person" ]
    then
        echo "Personal transfer"

        local name=$(cGetName)
        if [ "$name" == "-1" ]; then return; fi
    
        local surnameOrNip=$(cGetSurname)
        if [ "$surnameOrNip" == "-1" ]; then return; fi
    elif [ "$1" == "Firm" ]
    then
        echo "Firm transfer"

        local name=$(cGetFirmsName)
        if [ "$name" == "-1" ]; then return; fi
    
        local surnameOrNip=$(cGetNip)
        if [ "$surnameOrNip" == "-1" ]; then return; fi
    else
        echo "ERROR. Wrong argument for function cCurrencyManualTransfer (either Person or Firm)."
        sleep 3
        exit 1
    fi
    
    local bankAccountNumber=$(cGetBankAccountNumber)
    if [ "$bankAccountNumber" == "-1" ]; then return; fi
    
    cGetCurrency
    local currency=$?
    if [ "$currency" == 0 ]; then return; fi

    local amountInOtherCurrency=$(cGetAmount "Type in amount of money to transfer: ")
    if [ "$amountInOtherCurrency" == "-1" ]; then return; fi

    cCurrencyTransfer $1 $name $surnameOrNip $bankAccountNumber $currency $amountInOtherCurrency
}

#Takes as arguments in that order: "Person"/"Firm", name, surname or NIP, bank account number, currency and 
#amount in that currency to transfer.
#Use carefully because there is no validation in that function (its not for user use) and you can damage database
function cCurrencyTransfer
{
    clear
    local type=$1
    local name=$2
    local surnameOrNip=$3
    local bankAccountNumber=$4  
    local currency=$5
    local amountInOtherCurrency=$6 
    local amount=$(KexchangeCalculation $amountInOtherCurrency $currency 10)

    local totalAmount=$(($amount+30))
    local transferPossibilityState=$(cCanYouTransfer $totalAmount)
    if [ $transferPossibilityState == 0 ] 
    then 
        echo "You don't have enough money to do this transfer."
        sleep 3
        return
    fi
    
    cGenerateCode
    cAuthentication

    cSetBalance $(($balance-$amount-20))
    cMakeAutomaticTransfer 10

    if [ $amount -gt 49 ]
    then
        cValidateTransfer $amount ${type,,} $name $surnameOrNip
        if [ $? == 0 ]
        then
            clear
            cSetBalance $(($balance+$amount))
            echo "Transfer has been reverted."
            sleep 3
            return
        fi
    fi

    cChooseOneOfTwoOptions "Press S if you want to save transfer separately or press C if you want to continue with defualt history storage." "S" "C"
    if [ $? == 1 ] 
    then 
        cSaveTransferSeparately $type "Currency" $(date +'%Y-%m-%d') $bankAccountNumber $amount $name $surnameOrNip
    fi

    cAddTransferToHistory $type "Currency" $(date +'%Y-%m-%d') $bankAccountNumber $amount $name $surnameOrNip

    clear
    echo "Your account balance is now:" $balance
    sleep 3
    return
}