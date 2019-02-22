#!/bin/bash

source $(dirname $0)/globalVariables.sh

function cSetBalance
{
    balance=$1
    sed -i "s/Balance: \(.*\)/Balance: $balance/" $(dirname $0)/globalVariables.txt
    cUpdateEntireBalance
}

function cSetSavings
{
    savings=$1
    sed -i "s/Balance: \(.*\)/Balance: $savings/" $(dirname $0)/SavingsAccount/savingsAccount.txt
    cUpdateEntireBalance
}

###########################################
#Do not touch these unless you know what you are doing. vv

function cSetupGlobalVariables
{
    cGetBalance
    cGetSavings
    cUpdateEntireBalance
}

function cGetBalance
{
    local fileBalance=$(awk '/Balance: /{print $2}' $(dirname $0)/globalVariables.txt)
    balance=$fileBalance
}

function cGetSavings
{
    if [ -f "$(dirname $0)/SavingsAccount/savingsAccount.txt" ]
    then
        local fileSavings=$(awk '/Balance: /{print $2}' $(dirname $0)/SavingsAccount/savingsAccount.txt)
        savings=$fileSavings
    else
        savings=0
    fi
}

function cUpdateEntireBalance
{
    let entire_balance=balance+savings
}