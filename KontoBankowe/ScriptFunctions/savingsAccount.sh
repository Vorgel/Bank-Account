#!/bin/bash

source $(dirname $0)/usefulFunctions.sh
source $(dirname $0)/globalVariablesFunctions.sh

function cCreateSavingsAccount
{
    local savingsAccountDirState=$(cCheckIfDirExists SavingsAccount)
    if [ $savingsAccountDirState == 0 ]; then mkdir $(dirname $0)/SavingsAccount; fi
    
    local savingsAccountState=$(cCheckIfFileExists SavingsAccount/savingsAccount.txt)
    if [ $savingsAccountState == 0 ]
    then
        touch $(dirname $0)/SavingsAccount/savingsAccount.txt
        printf "%s\n" "Balance: 0" >> $(dirname $0)/SavingsAccount/savingsAccount.txt
        printf "%s\n" "Monthly: 0" >> $(dirname $0)/SavingsAccount/savingsAccount.txt
        printf "%s\n" "Goal: 0" >> $(dirname $0)/SavingsAccount/savingsAccount.txt
    fi
}

function cSetMonthlySavings
{
    clear
    local monthlySavings=$(cGetAmount "Set how much money would you like to save per month: ")
    if [ "$monthlySavings" == "-1" ]; then return; fi

    sed -i "s/Monthly: \(.*\)/Monthly: $monthlySavings/" $(dirname $0)/SavingsAccount/savingsAccount.txt
}

function cSetGoal
{
    clear
    local goal=$(cGetAmount "Set your saving goal: ")
    if [ "$goal" == "-1" ]; then return; fi

    sed -i "s/Goal: \(.*\)/Goal: $goal/" $(dirname $0)/SavingsAccount/savingsAccount.txt
}

#Takes amount as an argument
function cMakeAutomaticTransfer
{
    cCreateSavingsAccount
    cSetBalance $(($balance-$1))
    local transferAmount=$1
    local transferFormat='^[0-9]+$'

    if ! [[ "$transferAmount" =~ $transferFormat ]]
    then
        echo "ERROR. cMakeAutomaticTransfer in savingsAccount.sh takes number bigger than 0 as an argument."
        sleep 3
        exit 1
    fi

    local savingsAccountBalance=$(awk '/Balance: /{print $2}' $(dirname $0)/SavingsAccount/savingsAccount.txt)
    savingsAccountBalance=$(echo $(($savingsAccountBalance+$transferAmount)))
    sed -i "s/Balance: \(.*\)/Balance: $savingsAccountBalance/" $(dirname $0)/SavingsAccount/savingsAccount.txt
}

function cMakeManualTransfer
{
    clear
    local transferAmount=$(cGetAmount "Type in amount of money you would like to transfer: ")
    if [ "$transferAmount" == "-1" ]; then return; fi

    local savingsAccountBalance=$(awk '/Balance: /{print $2}' $(dirname $0)/SavingsAccount/savingsAccount.txt)
    savingsAccountBalance=$(echo $(($savingsAccountBalance+$transferAmount)))
    sed -i "s/Balance: \(.*\)/Balance: $savingsAccountBalance/" $(dirname $0)/SavingsAccount/savingsAccount.txt
}

function cDisplaySavingsAccountInformation
{
    clear
    echo "Information | Savings account"

    while read -r line 
    do
        echo $line
    done < "$(dirname $0)/SavingsAccount/savingsAccount.txt"

    local monthly=$(awk '/Monthly: /{print $2}' $(dirname $0)/SavingsAccount/savingsAccount.txt)
    local goal=$(awk '/Goal: /{print $2}' $(dirname $0)/SavingsAccount/savingsAccount.txt)
    local gatheredMoney=$(awk '/Balance: /{print $2}' $(dirname $0)/SavingsAccount/savingsAccount.txt)
    local leftToGoal=$(($goal-$gatheredMoney))
    local timeToGoal

    if [ "$gatheredMoney" -gt "$goal" ]
    then
        echo "You have already achieved your goal."
    elif [ "$monthly" == 0 ]
    then
        echo "You haven't setup your monthly payment yet."
    elif [ "$goal" == 0 ]
    then
        echo "You haven't setup your goal yet."
    else
        let timeToGoal=leftToGoal/monthly      
        if [ $(( $leftToGoal % $monthly)) != 0 ]; then let timeToGoal++; fi

        echo "It will take you" $timeToGoal "more months to achieve your goal of saving" $goal"."
    fi

    read -n 1 -s -r -p "Press any key to continue..."
}

function cSavingsAccount
{
    clear
    cCreateSavingsAccount

    echo "Menu | Savings account"
    echo "1. Display information about your savings account."
    echo "2. Set monthly savings."
    echo "3. Make transfer manually."
    echo "4. Set goal."
 
    local option
    echo -n "Press desired option number in order to continue or press R in order to return to the previous page. "
    read -rsn1 option

    if [ "$option" == 1 ]
    then
        cDisplaySavingsAccountInformation
    elif [ "$option" == 2 ]
    then
        cSetMonthlySavings
    elif [ "$option" == 3 ]
    then
        cMakeManualTransfer
    elif [ "$option" == 4 ]
    then
        cSetGoal
    elif [ "$option" == "r" ] || [ "$option" == "R" ]
    then
        return
    fi

    cSavingsAccount
}