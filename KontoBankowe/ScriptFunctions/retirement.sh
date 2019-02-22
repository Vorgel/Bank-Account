#!/bin/bash
# Potrzebny plik retirement.txt w ktorym linia po lini wpisane bylyby miesieczne skladki (bylby ogromny)
# Funkcja pobiera skladki, liczy je i oblicza emeryture (dla Polaka odchodzacego na emeryture w wieku 65 lat)

function Kretirement()
{
    local moneycollected=0
    local monthlyPayment=0
    local index=0

    while read -r line 
    do
        retirementMoney[$index]="$line"
        let moneycollected=$(echo $moneycollected+${retirementMoney[$index]})
        echo $moneycollected
        let index++

    done < "retirement.txt"

    let monthlyPayment=moneycollected/218 #218 to srednia zycia w miesiacach dla 65latka

    echo "Monthly retirement payment at the age of 65: ""$monthlyPayment"
    read -rsn1 monthlyPayment
}