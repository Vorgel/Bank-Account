#!/bin/bash

function cCheckIfDirExists
{
    if [ -d "$(dirname $0)/$1" ]
    then
        echo 1
    else
        echo 0
    fi
}

function cCheckIfFileExists
{
    if [ -f "$(dirname $0)/$1" ]
    then
        echo 1
    else
        echo 0
    fi
}

function cChooseOneOfTwoOptions
{
    local option
    echo $1
    read -rsn1 option

    if [ "$option" == "${2^^}" ] || [ "$option" == "${2,,}" ]
    then
        return 1
    elif [ "$option" == "${3^^}" ] || [ "$option" == "${3,,}" ]
    then
        return 0
    else
        cChooseOneOfTwoOptions $1 $2 $3
    fi
}

function cGetNumberWithGivenLength
{
    local numberFormat="^[0-9]{$2}$"

    if [[ "$1" =~ $numberFormat ]]
    then
        echo 1
    else
        echo 0
    fi
}

function cGetName
{
    local name
    read -p "Type in name: " name
    local nameFormat='^[A-Z][a-z][a-z]+$'
    if ! [[ "$name" =~ $nameFormat ]]; 
    then 
        echo -1
        echo "Wrong format. Has to start with upperscase letter, has to have at least 3 letters and only letters" >&2
        sleep 3
    else
        echo $name
    fi
}

function cGetSurname
{
    local surname
    read -p "Type in surname: " surname
    local surnameFormat='^[A-Z][a-z][a-z]+$'
    if ! [[ "$surname" =~ $surnameFormat ]]; 
    then 
        echo -1
        echo "Wrong format. Has to start with upperscase letter, has to have at least 3 letters and only letters" >&2
        sleep 3
    else
        echo $surname
    fi
}

function cGetFirmsName
{
    local name
    read -p "Type in firms name: " name
    local nameFormat='^[a-zA-Z0-9-]+$'
    if ! [[ "$name" =~ $nameFormat ]]; 
    then 
        echo -1
        echo "Wrong firm name format. Can contain only letters, digits and hyphens."  >&2
        sleep 3
    else
        echo $name
    fi
}

function cGetBankAccountNumber
{
    local bankAccountNumber
    read -p "Type in bank account number: " bankAccountNumber
    local bankAccountNumberState=$(cGetNumberWithGivenLength $bankAccountNumber 26)
    if [ $bankAccountNumberState == 0 ]; 
    then 
        echo -1
        echo "Wrong format. Has to have 26 digits and only digits." >&2
        sleep 3 
    else
        echo $bankAccountNumber
    fi
}

function cGetPesel
{
    local pesel
    read -p "Type in PESEL: " pesel
    local peselState=$(cGetNumberWithGivenLength $pesel 11)
    if [ $peselState == 0 ]; 
    then 
        echo -1
        echo "Wrong format. Has to have 11 digits and only digits." >&2
        sleep 3 
    else
        echo $pesel
    fi
}

function cGetNip
{
    local nip
    read -p "Type in firms NIP number: " nip
    local nipState=$(cGetNumberWithGivenLength $nip 10)
    if [ $nipState == 0 ]; 
    then 
        echo -1
        echo "Wrong format. Has to have 10 digits and only digits." >&2
        sleep 3 
    else
        echo $nip
    fi
}

#Takes message as an argument
function cGetAmount
{
    local amount
    read -p "$1" amount
    local amountFormat='^([1-9][0-9]*)$'
    if ! [[ "$amount" =~ $amountFormat ]]; 
    then 
        echo -1
        echo "Wrong format. Has to be greater than 0 and can contain digits only." >&2
        sleep 3
    else
        echo $amount
    fi
}

function cGetDayOfTheMonth
{
    local day
    read -p "$1" day
    local dayFormat='^([1-9]|([1-2][0-9])|30)$'
    if ! [[ "$day" =~ $dayFormat ]]; 
    then 
        echo -1
        echo "Wrong format. Has to be greater than 0 and can contain digits only." >&2
        sleep 3
    else
        echo $day
    fi
}