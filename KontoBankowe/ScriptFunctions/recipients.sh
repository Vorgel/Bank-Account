#!/bin/bash

source $(dirname $0)/usefulFunctions.sh

function cCreateRecipientsFile
{
    local recipientsFileState=$(cCheckIfFileExists recipients.txt)
    if [ $recipientsFileState == 0 ]; then touch $(dirname $0)/recipients.txt; fi
}

function cAddRecipient
{
    clear
    cCreateRecipientsFile

    local name=$(cGetName)
    if [ "$name" == "-1" ]; then return; fi
    
    local surname=$(cGetSurname)
    if [ "$surname" == "-1" ]; then return; fi
    
    local pesel=$(cGetPesel)
    if [ "$pesel" == "-1" ]; then return; fi
    
    local bankAccountNumber=$(cGetBankAccountNumber)
    if [ "$bankAccountNumber" == "-1" ]; then return; fi

    printf "%s" "$name " >> $(dirname $0)/recipients.txt
    printf "%s" "$surname " >> $(dirname $0)/recipients.txt
    printf "%s" "$pesel " >> $(dirname $0)/recipients.txt
    printf "%s" "$bankAccountNumber" >> $(dirname $0)/recipients.txt
    echo "" >> $(dirname $0)/recipients.txt
}

function cDeleteRecipient
{
    clear
    local pesel=$(cGetPesel)
    if [ "$pesel" == "-1" ]; then return; fi

    sed -i "/ $pesel /d" $(dirname $0)/recipients.txt
}

function cGetRecipients
{
    clear
    cCreateRecipientsFile

    local -a recipients=()
    local index=0

    while read -r line 
    do
        recipients[$index]="$line"
        let index++
    done < $(dirname $0)/recipients.txt

    if [ ${#recipients[@]} == 0 ] 
    then 
        echo "No set recipients." 
        sleep 3
        return 
    fi

    local -a recipientsName=()
    local -a recipientsSurname=()
    local -a recipientsPESEL=()
    local -a recipientsBankAccountNumber=()

    for (( i=0; i<$index; i++ ))
    do
        local recipient=(${recipients[$i]})

        recipientsName[$i]=${recipient[0]}
        recipientsSurname[$i]=${recipient[1]}
        recipientsPESEL[$i]=${recipient[2]}
        recipientsBankAccountNumber[$i]=${recipient[3]}
    done

    for (( i=0; i<$index; i++ ))
    do
        echo "Recipient" $(($i+1))":"
        echo "Name:" ${recipientsName[$i]}
        echo "Surname:" ${recipientsSurname[$i]}
        echo "PESEL:" ${recipientsPESEL[$i]}
        echo "Bank account number:" ${recipientsBankAccountNumber[$i]}
        echo ""
    done
    
    read -n 1 -s -r -p "Press any key to continue..."
}

function cDisplayRecipientsMenu
{
    clear
    echo "Menu | Recipients"
    echo "1. Display recipients"
    echo "2. Add recipient"
    echo "3. Delete recipient"
    
    local option
    echo -n "Press desired option number in order to continue or press R in order to return to the previous page. "
    read -rsn1 option

    if [ "$option" == 1 ]
    then
        cGetRecipients
    elif [ "$option" == 2 ]
    then
        cAddRecipient
    elif [ "$option" == 3 ]
    then
        cDeleteRecipient
    elif [ "$option" == "r" ] || [ "$option" == "R" ]
    then
        return
    fi
    
    cDisplayRecipientsMenu
}