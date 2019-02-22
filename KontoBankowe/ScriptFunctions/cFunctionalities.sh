#!/bin/bash

#All big functionalities that I've created in one place so it's easier to work with them as a whole: not with only parts of them.
#There are few smaller ones that you can probably find in usefulFunctions.sh, zus.sh or any other files that you can find on my github branch.

source $(dirname $0)/savingsAccount.sh
source $(dirname $0)/recipients.sh
source $(dirname $0)/transfersMenu.sh
source $(dirname $0)/standingOrders.sh

function cSavingsAccountFunctionality
{
    cSavingsAccount
}

function cRecipientsFunctionality
{
    cDisplayRecipientsMenu
}

function cTransfersFunctionality
{
    cTransfersGeneralMenu
}

function cStandingOrdersFunctionality
{
    cDisplayStandingOrderGeneralMenu
}