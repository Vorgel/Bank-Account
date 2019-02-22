#!/bin/bash

source $(dirname $0)/ordinaryTransfer.sh

function cTransferToZus
{
    clear
    cCreateStandingOrdersFile

    local zusInfoLine=$(grep ZUS "$(dirname $0)/standingOrders.txt")

    if ! [ "$zusInfoLine" ] 
    then 
        echo "You haven't setup your ZUS standing order yet."
        echo "You need to do this before attempting an automatic transfer to ZUS."
        sleep 3
        return
    fi
    
    local zusInfo=($zusInfoLine)
    local amount=$(kCalculateZus 2665 3554)

    cOrdinaryTransfer ${zusInfo[0]} ${zusInfo[1]} ${zusInfo[2]} ${zusInfo[3]} ${zusInfo[4]}
}