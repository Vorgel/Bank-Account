#!/bin/bash

source $(dirname $0)/usefulFunctions.sh

function cCreateHistory
{
    local historyDirState=$(cCheckIfDirExists Account)
    if [ $historyDirState == 0 ]; then mkdir $(dirname $0)/Account; fi
    
    local historyFileState=$(cCheckIfFileExists Account/transfersHistory.txt)
    if [ $historyFileState == 0 ]; then touch $(dirname $0)/Account/transfersHistory.txt; fi
    
    local separateTransfersDirState=$(cCheckIfDirExists Account/SeparateTransfers)
    if [ $separateTransfersDirState == 0 ]; then mkdir $(dirname $0)/Account/SeparateTransfers; fi
}

#Takes as an arguments in that order: "Person", transfer type, date, bank account number, amount, recipients name, recipients surname
#OR
#Takes as an arguments in that order: "Firm", transfer type, date, bank account number, amount, firms name, NIP
function cAddTransferToHistory
{
    cCreateHistory

    local index=1
    while read -r line 
    do
        let index++
    done < "$(dirname $0)/Account/transfersHistory.txt"

    printf "%s" "$1 " >> $(dirname $0)/Account/transfersHistory.txt
    printf "%s" $2 "-transfer-" $index" " >> $(dirname $0)/Account/transfersHistory.txt
    printf "%s" "$3 " >> $(dirname $0)/Account/transfersHistory.txt
    printf "%s" "$4 " >> $(dirname $0)/Account/transfersHistory.txt
    printf "%s" "$5 " >> $(dirname $0)/Account/transfersHistory.txt
    printf "%s" "$6 " >> $(dirname $0)/Account/transfersHistory.txt
    printf "%s" "$7" >> $(dirname $0)/Account/transfersHistory.txt
    echo "" >> $(dirname $0)/Account/transfersHistory.txt
}

function cGetTransfersHistory
{
    clear
    cCreateHistory

    local -a transfers=()
    local index=0

    while read -r line 
    do
        transfers[$index]="$line"
        let index++
    done < "$(dirname $0)/Account/transfersHistory.txt"

    if [ $index == 0 ]; then echo "You do not have any transfers in the transfers history yet."; return; fi

    local -a ordinaryTransfers=()
    local -a expressTransfers=()
    local -a currencyTransfers=()
    local ordinaryTransferFormat='^Ordinary-transfer-([0-9]+)$'
    local expressTransferFormat='^Express-transfer-([0-9]+)$'
    local currencyTransferFormat='^Currency-transfer-([0-9]+)$'

    for (( i=0; i<$index; i++ ))
    do
        local transfer=(${transfers[$i]})

        if [[ "${transfer[1]}" =~ $ordinaryTransferFormat ]];
        then
            ordinaryTransfers+=("${transfers[$i]}")
        elif [[ "${transfer[1]}" =~ $expressTransferFormat ]];
        then
            expressTransfers+=("${transfers[$i]}")
        elif [[ "${transfer[1]}" =~ $currencyTransferFormat ]];
        then
            currencyTransfers+=("${transfers[$i]}")
        else
            echo "ERROR. Currupted data in transferHistory.txt file."
            sleep 3
            exit 1
        fi
    done

    if [ ${#ordinaryTransfers[@]} -gt 0 ]
    then
        echo "Ordinary transfers: "
        echo ""
        cPrintTransfersData "${ordinaryTransfers[@]}"
    fi

    if [ ${#expressTransfers[@]} -gt 0 ]
    then
        echo "Express transfers: "
        echo ""
        cPrintTransfersData "${expressTransfers[@]}"
    fi

    if [ ${#currencyTransfers[@]} -gt 0 ]
    then
        echo "Currency transfers: "
        echo ""
        cPrintTransfersData "${currencyTransfers[@]}"
    fi

    read -n 1 -s -r -p "Press any key to continue..."
}

function cPrintTransfersData
{
    local -a transfers=("$@")
    local -a personalTransfers=()
    local -a firmTransfers=()

    for (( i=0; i<${#transfers[@]}; i++ ))
    do
        local transfer=(${transfers[$i]})

        if [ ${transfer[0]} == "Person" ] 
        then
            personalTransfers+=("${transfers[$i]}")
        elif [ ${transfer[0]} == "Firm" ]
        then
            firmTransfers+=("${transfers[$i]}")
        else
            echo "ERROR. Currupted data in transferHistory.txt file."
            sleep 3
            exit 1
        fi
    done
    
    if [ ${#personalTransfers[@]} -gt 0 ]
    then
        echo "  Personal transfers: "
        echo ""
    fi

    for (( i=0; i<${#personalTransfers[@]}; i++ ))
    do
        local transfer=(${personalTransfers[$i]})
        
        echo "    Transfer" $(($i+1))":"
        echo "    Date:" ${transfer[2]}
        echo "    Bank account number:" ${transfer[3]}
        echo "    Amount:" ${transfer[4]}
        echo "    Name:" ${transfer[5]}
        echo "    Surname:" ${transfer[6]}
        echo ""
    done

    if [ ${#firmTransfers[@]} -gt 0 ]
    then
        echo "  Firm transfers: "
        echo ""
    fi

    for (( i=0; i<${#firmTransfers[@]}; i++ ))
    do
        local transfer=(${firmTransfers[$i]})
        
        echo "    Transfer" $(($i+1))":"
        echo "    Date:" ${transfer[2]}
        echo "    Bank account number:" ${transfer[3]}
        echo "    Amount:" ${transfer[4]}
        echo "    Firm:" ${transfer[5]}
        echo "    NIP:" ${transfer[6]}
        echo ""
    done
}

#Takes as an arguments in that order: "Person", transfer type, date, bank account number, amount, recipients name, recipients surname
#OR
#Takes as an arguments in that order: "Firm", transfer type, date, bank account number, amount, firms name, NIP
function cSaveTransferSeparately
{
    local index=1

    while read -r line 
    do
        let index++
    done < "$(dirname $0)/Account/transfersHistory.txt"

    local transferType
    local ordinaryTransferFormat='^Ordinary-transfer-([0-9]+)$'
    local expressTransferFormat='^Express-transfer-([0-9]+)$'
    local currencyTransferFormat='^Currency-transfer-([0-9]+)$'
    
    if [[ $2 =~ $ordinaryTransferFormat ]]; then transferType="Ordinary transfer"; fi
    if [[ $2 =~ $expressTransferFormat ]]; then transferType="Express transfer"; fi
    if [[ $2 =~ $currencyTransferFormat ]]; then transferType="Currency transfer"; fi

    touch $(dirname $0)/Account/SeparateTransfers/$3_$index.txt

    printf '%s\n' "$transferType" > $(dirname $0)/Account/SeparateTransfers/$3_$index.txt

    if [ "$1" == "Person" ]
    then
        printf '%s\n' "Name: $6" >> $(dirname $0)/Account/SeparateTransfers/$3_$index.txt
        printf '%s\n' "Surname: $7" >> $(dirname $0)/Account/SeparateTransfers/$3_$index.txt
    elif [ "$1" == "Firm" ]
    then
        printf '%s\n' "Firm: $6" >> $(dirname $0)/Account/SeparateTransfers/$3_$index.txt
        printf '%s\n' "NIP: $7" >> $(dirname $0)/Account/SeparateTransfers/$3_$index.txt
    else
        echo "ERROR. Wrong argument for cSaveTransferSeparately (either Person or Firm)."
        sleep 3
        exit 1 
    fi

    printf '%s\n' "Date: $3" >> $(dirname $0)/Account/SeparateTransfers/$3_$index.txt
    printf '%s\n' "Bank account number: $4" >> $(dirname $0)/Account/SeparateTransfers/$3_$index.txt
    printf '%s\n' "Amount: $5" >> $(dirname $0)/Account/SeparateTransfers/$3_$index.txt
}