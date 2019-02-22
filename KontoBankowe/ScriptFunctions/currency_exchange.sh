#!/bin/bash
# Funkcja exchange pobiera informacje z pliku tekstowego ''currency_exchange.txt" na temat ceny walut.
# Funkcja przyjmuje jako argument aktualny stan konta uzytkownika. - $1 (ogolnie $balance)
# Uzytkownik daje informacje na jaka walute chcialby przeliczyc swoje pieniadze i dostaje informacje ile pieniedzy posiada w wybranej walucie. Wszystko jest zalezne od stanu konta

source $(dirname $0)/globalVariables.sh 

function Kexchange()
{
    until [ "$wantedCurrency" == "r" ]
    do

        local currencyNameFormat='^([1-9]|10|r)$'
        local currencyName=""
        local wantedCurrency=0
        local actualCurrency=10
        local balanceAfter=0
        local counterExchange=0
        local useless

        clear
        echo -e "Choose currency you want your money to be exchanged to: \n""1) ZAR South African Rand\n""2) TRY Turkish Lira\n""3) RON Romanian leu\n""4) NZD New Zealand dollar\n""5) MXN Mexican Peso\n""6) HRK Croatian kuna\n""7) BGN Bulgarian Lev\n""8) AED Dirham of the United Arab Emirates\n""9) ILS Israeli New Sheqel\n""10) PLN Polish zloty\n""r) Return"

        read wantedCurrency

        if ! [[ "$wantedCurrency" =~ $currencyNameFormat ]] || [[ "$wantedCurrency" == $actualCurrency ]]
        then
            until [[ "$wantedCurrency" =~ $currencyNameFormat ]] && ! [[ "$wantedCurrency" == $actualCurrency ]]
            do
                clear
                echo "Incorrect input. Try again: "
                echo -e "Choose currency you want your money to be exchanged to: \n""1) ZAR South African Rand\n""2) TRY Turkish Lira\n""3) RON Romanian leu\n""4) NZD New Zealand dollar\n""5) MXN Mexican Peso\n""6) HRK Croatian kuna\n""7) BGN Bulgarian Lev\n""8) AED Dirham of the United Arab Emirates\n""9) ILS Israeli New Sheqel\n""10) PLN Polish zloty\n""r) Return"
                read wantedCurrency
            done
        fi  

        if [ "$wantedCurrency" == "r" ]
        then
            echo ""
        else

            if ! [[ "$1" -gt "0" ]]
            then
                echo "You have no founds!"
                wantedCurrency="r"
                local siema
                read -rsn1 siema
            else
                IFS=$'\n'
                for line in $(<currency_exchange.txt)
                do
                    let counterExchange++
                    if [ $counterExchange == $wantedCurrency ]
                    then
                        currencyName=${line% *}
                    fi
                done

                balanceAfter=$(KexchangeCalculation $1 $actualCurrency $wantedCurrency) 
                echo "$balanceAfter"" $currencyName"
                actualCurrency=$wantedCurrency
		        read -rsn1 useless
            fi  
        fi
    done
}

function KexchangeCalculation()
{
    local counterExchange=0
    local exchange2=""
    local exchange3=""
    local result=0

    IFS=$'\n'
    for line in $(<currency_exchange.txt)
    do
        let counterExchange++
        if [ "$counterExchange" == "$2" ]
        then
            exchange2=${line#* }
        fi
    done

    counterExchange=0

    IFS=$'\n'
    for line in $(<currency_exchange.txt)
    do
        let counterExchange++
        if [ "$counterExchange" == "$3" ]
        then
            exchange3=${line#* }
        fi
    done

    result=$(awk -v a="$1" -v b="$exchange2" -v c="$exchange3" 'BEGIN {print a*b/c}')
    result=${result/.*}
    echo $result
}
