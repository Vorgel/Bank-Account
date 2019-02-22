#!/bin/bash
# Potrzebne pliki: savings.txt bank_acc_info.txt
# Funkcja ma za zadanie pokazac ile uzytkownik ma oszczednosci oraz obliczyc ile zajmie mu czasu na uzyskanie wybranej sumy
# Obliczanie czasu opiera sie na pobieraniu daty z pliku, obliczaniu roznicy miedzy data z pliku a data lokalna w dniach, nastepnie oblizanie codziennego zwiekszenia oszczednosci i na podstawie tego oblicza nam dni do wymarzonej kwoty
function savings()
{
    local dreamMoneyFormat='^[0-9]+$'
    local savingsAmount=$(cat savings.txt)
    local dreamMoney
    local localData=`date +%Y-%m-%d`
    local counterSavings=0
    local savingsData
    local diffrenceMoney
    local daysToReach

    IFS=$'\n'
    for line in $(<bank_acc_info.txt)
    do
        let countersavings++

        if [ $countersavings == 2 ]
        then
            savingsData=${line#* }
            echo $savingsData
        fi
    done

    diffrenceDates=$(( (`date -d $localData +%s` - `date -d $savingsData +%s`) / 86400 ))   
    let savingsIncomePerDay=savingsAmount/diffrenceDates

    echo "Enter the amount of money you would like to save: "
    read dreamMoney

    if ! [[ "$dreamMoney" =~ $dreamMoneyFormat ]]
    then
        until [[ "$dreamMoney" =~ $dreamMoneyFormat ]] 
        do
                clear
                echo "Incorrect input. Try again: "
                echo "Type the amount of money you want to reach: "
                read dreamMoney
        done
    fi

    if [ $dreamMoney -le $savingsAmount]
    then
        echo "You already reached it."
    else
        let diffrenceMoney=dreammoney-savingsAmount
        let daysToReach=diffrenceMoney/savingsIncomePerDay

        echo "Days to reach the wanted savings: ""$daysToReach"
    fi
}