#!/bin/bash

source $(dirname $0)/usefulFunctions.sh

function cCreateStandingOrdersFile
{
    local standingOrdersFileState=$(cCheckIfFileExists standingOrders.txt)
    if [ $standingOrdersFileState == 0 ]; then touch $(dirname $0)/standingOrders.txt; fi
}

#This is the function that you probably want to use if you want to add or delete a standing order
function cDisplayStandingOrderGeneralMenu
{
    clear
    echo "Menu | Standing order"
    echo "1. Display standing orders"
    echo "2. Add ZUS to standing orders"
    echo "3. Add standing order"
    echo "4. Delete standing order"

    local option
    echo -n "Press desired option number in order to continue or press R in order to return to the previous page. "
    read -rsn1 option

    if [ "$option" == 1 ]
    then
        cGetStandingOrders
    elif [ "$option" == 2 ]
    then
        cAddZusToStandingOrders
    elif [ "$option" == 3 ]
    then
        cDisplayStandingOrderSpecificMenu "Add"
    elif [ "$option" == 4 ]
    then
        cDisplayStandingOrderSpecificMenu "Delete"
    elif [ "$option" == "r" ] || [ "$option" == "R" ]
    then
        return
    fi
        
    cDisplayStandingOrderGeneralMenu
}

#It takes "Add" or "Delete" as an argument
function cDisplayStandingOrderSpecificMenu
{
    clear
    echo "$1 menu | Standing order types"
    echo "1. Personal"
    echo "2. Firm"

    local option
    echo -n "Press desired option number in order to continue or press R in order to return to the previous page. "
    read -rsn1 option

    if [ $1 == "Add" ]
    then
        if [ "$option" == 1 ]
        then
            cAddStandingOrderManually 1
        elif [ "$option" == 2 ]
        then
            cAddStandingOrderManually 2
        elif [ "$option" == "r" ] || [ "$option" == "R" ]
        then
            cDisplayStandingOrderGeneralMenu
            return
        fi
    else
        if [ "$option" == 1 ]
        then
            cDeleteStandingOrderManually 1
        elif [ "$option" == 2 ]
        then
            cDeleteStandingOrderManually 2
        elif [ "$option" == "r" ] || [ "$option" == "R" ]
        then
            cDisplayStandingOrderGeneralMenu
            return
        fi
    fi

    cDisplayStandingOrderSpecificMenu $1
}

#Do not use that function unless you know what you are doing.
#You probably want to use cDisplayStandingOrderGeneralMenu function instead.
function cDeleteStandingOrderManually
{
    clear
    if [ $1 == "1" ]
    then
        local pesel=$(cGetPesel)
        if [ "$pesel" == "-1" ]; then return; fi

        cDeleteStandingOrder "Person" $pesel
    else
        local nip=$(cGetNip)
        if [ "$nip" == "-1" ]; then return; fi

        cDeleteStandingOrder "Firm" $nip
    fi
}

#Do not use that function unless you know what you are doing.
#You probably want to use cDisplayStandingOrderGeneralMenu function instead.
function cAddStandingOrderManually
{
    clear
    local orderType

    if [ $1 == "1" ] 
    then
        orderType="Person"

        local name=$(cGetName)
        if [ "$name" == "-1" ]; then return; fi
        
        local surname=$(cGetSurname)
        if [ "$surname" == "-1" ]; then return; fi
        
        local pesel=$(cGetPesel)
        if [ "$pesel" == "-1" ]; then return; fi
    elif [ $1 == "2" ]
    then
        orderType="Firm"

        local firmName=$(cGetFirmsName)
        if [ "$firmName" == "-1" ]; then return; fi
        
        local nip=$(cGetNip)
        if [ "$nip" == "-1" ]; then return; fi
    else
        echo "ERROR. Wrong argument for function cAddStandingOrderManually (either 1 or 2 are admissible)"
        sleep 3
        exit 1
    fi

    local bankAccountNumber=$(cGetBankAccountNumber)
    if [ "$bankAccountNumber" == "-1" ]; then return; fi
    
    local amount=$(cGetAmount "Type in the amount of money you will be sending: ")
    if [ "$amount" == "-1" ]; then return; fi
    
    local day=$(cGetDayOfTheMonth "Type in the day of the month you will be sending the money: ")
    if [ "$day" == "-1" ]; then return; fi

    if [ $orderType == "Person" ]
    then
        cAddStandingOrder "Person" $bankAccountNumber $amount $day $name $surname $pesel
    else
         cAddStandingOrder "Firm" $bankAccountNumber $amount $day $firmName $nip
    fi
}

#Takes 6 or 7 arguments
#If the first one is "Person" it takes 6 more arguments in that order:
#Bank account number, amount, day of the month, recipients name, surname and their PESEL
#If the first one is "Firm" it takes 5 more arguments in that order:
#Bank account number, amount, day of the mount, firms name and its NIP
#There is no validation in that function so make sure you are sending right data
function cAddStandingOrder
{
    cCreateStandingOrdersFile
    printf "%s" "$1 " >> $(dirname $0)/standingOrders.txt

    if [ $1 == "Person" ]
    then
        printf "%s" "$5 " >> $(dirname $0)/standingOrders.txt
        printf "%s" "$6 " >> $(dirname $0)/standingOrders.txt
        printf "%s" "$7 " >> $(dirname $0)/standingOrders.txt
    elif [ $1 == "Firm" ]
    then
        printf "%s" "$5 " >> $(dirname $0)/standingOrders.txt
        printf "%s" "$6 " >> $(dirname $0)/standingOrders.txt
    else
        echo "ERROR. Wrong order type argument for cAddStandingOrder in standingOrders.sh - read comments."
        sleep 3
        exit 1
    fi

    printf "%s" "$2 " >> $(dirname $0)/standingOrders.txt
    printf "%s" "$3 " >> $(dirname $0)/standingOrders.txt
    printf "%s" "$4 " >> $(dirname $0)/standingOrders.txt
    echo "" >> $(dirname $0)/standingOrders.txt
}

#It takes 2 arguments: order type ("Person" or "Firm") and depending on the type: PESEL (11 digits) or NIP (10 digits)
function cDeleteStandingOrder
{
    cCreateStandingOrdersFile

    if [ "$1" == "Person" ]
    then
        local peselFormat='^[0-9]{11}$'

        if ! [[ "$2" =~ $peselFormat ]];
        then
            echo "ERROR. Wrong PESEL argument for cDeleteStandingOrder in standingOrders.sh (11 digits and only digits)"
            sleep 3
            exit 1
        fi

        sed -i "/ $2 /d" $(dirname $0)/standingOrders.txt
    elif [ "$1" == "Firm" ]
    then
        local nipFormat='^[0-9]{10}$'

        if ! [[ "$2" =~ $nipFormat ]];
        then
            echo "ERROR. Wrong NIP argument for cDeleteStandingOrder in standingOrders.sh (10 digits and only digits)"
            sleep 3
            exit 1
        fi

        sed -i "/ $2 /d" $(dirname $0)/standingOrders.txt
    else
        echo "ERROR. Wrong order type argument for cDeleteStandingOrder in standingOrders.sh (either Person or Firm are admissible)"
        sleep 3
        exit 1
    fi
}

function cAddZusToStandingOrders
{
    clear
    local zusInfo=$(grep ZUS "$(dirname $0)/standingOrders.txt")

    if ! [ "$zusInfo" ]
    then
        local pusPercentage="0.3409"
        local puzPercentage="0.09"
        local pus=$(awk -v a="2665" -v b="$pusPercentage" 'BEGIN {print a*b}')
        local puz=$(awk -v a="3554" -v b="$puzPercentage" 'BEGIN {print a*b}')
        local zusValue=$(awk -v a="$pus" -v b="$puz" 'BEGIN {print a+b}')
        zusValue=${zusValue/.*}

        cAddStandingOrder "Firm" "99999999999999999999999999" $zusValue "15" "ZUS" "0000000000"

        echo "Added ZUS to standing orders."
        sleep 3
    else
        echo "You already have ZUS in your standing orders."
        sleep 3
    fi
}

function cGetStandingOrders
{
    clear
    cCreateStandingOrdersFile

    local -a standingOrders=()
    local -a standingFirmOrders=()
    local -a standingPersonOrders=()
    local index=0

    while read -r line 
    do
        standingOrders[$index]="$line"
        let index++
    done < "$(dirname $0)/standingOrders.txt"

    if [ ${#standingOrders[@]} == 0 ]
    then
        echo "You don't have any standing orders yet."
        read -n 1 -s -r -p "Press any key to continue..."
        return
    fi

    for (( i=0; i<$index; i++ ))
    do
        local standingOrder=(${standingOrders[$i]})

        if [ "${standingOrder[0]}" == "Firm" ]
        then
            standingFirmOrders+=("${standingOrders[$i]}")
        else
            standingPersonOrders+=("${standingOrders[$i]}")
        fi
    done

    if [ ${#standingFirmOrders[@]} -gt 0 ]
    then
        echo "Firm standing orders:"
        echo ""

        for (( i=0; i<${#standingFirmOrders[@]}; i++ ))
        do
            local standingOrder=(${standingFirmOrders[$i]})

            echo "Order" $(($i+1))":"
            echo "Firms name:" ${standingOrder[1]}
            echo "NIP:" ${standingOrder[2]}
            echo "Bank account number:" ${standingOrder[3]}
            echo "Amount:" ${standingOrder[4]}
            echo "Day of the month for the payment:" ${standingOrder[5]}
            echo ""
        done
    fi

    if [ ${#standingPersonOrders[@]} -gt 0 ]
    then
        echo "Personal standing orders:"
        echo ""

        for (( i=0; i<${#standingPersonOrders[@]}; i++ ))
        do
            local standingOrder=(${standingPersonOrders[$i]})

            echo "Order" $(($i+1))":"
            echo "Persons name:" ${standingOrder[1]}
            echo "Surname:" ${standingOrder[2]}
            echo "PESEL:" ${standingOrder[3]}
            echo "Bank account number:" ${standingOrder[4]}
            echo "Amount:" ${standingOrder[5]}
            echo "Day of the month for the payment:" ${standingOrder[6]}
            echo ""
        done
    fi

    read -n 1 -s -r -p "Press any key to continue..."
}