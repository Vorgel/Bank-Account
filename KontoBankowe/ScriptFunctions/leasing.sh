#!/bin/bash


function mShowFromLeasing()
{ 
    local showFromTxt="leasing_formulas.txt"

    if [ -s $showFromTxt ]
    then 
        if [ `whoami`=$USER ]
        then
            clear
            cat $showFromTxt
        else 
            echo "You must be root to do that"
        fi
    else
        echo "cannot read There might be no formulas added or file doesn't exists"
    fi
}


#mozna usnunac istnieje w card_and_telPaye
function mmValidateNumber()
{
    local number=$1
    local numberLength=$2
    local numberFormat="^[0-9]{$numberLength}$"

    if [[ "$number" =~ $numberFormat ]]
    then
        echo 1
    else
        echo 0
    fi
}
#mozna usnunac istnieje w card_and_telPaye
function mmValidateWord
{
    local word=$1    
    local wordFormat='^[A-Z][a-z][a-z]+$'

    if [[ "$word" =~ $wordFormat ]]
    then
        echo 1
    else
        echo 0
    fi
}

function mValidateMonth
{
    local number=$1
    local numberLength=$2 
    local wordFormat="^[0-9]{$numberLength}$"

    if [[ "$number" =~ $wordFormat ]] && [[ $(($number%12)) -eq 0 ]]
    then
        echo 1
    else
        echo 0
    fi
}



#usun wez funkcje z card_and tel payment
function mmValidatePick
{
    local pic=$1

    until  [[ $pic -gt 0 ]] && [[ $pic =~ $re ]] && [[ $pic -lt 3 ]]
    do 
        echo "Expected number from 1 to 3"
        echo "Enter again"
        read pic
        clear 
    done 

}

function passIfCorrectForWord()
{
    local variable=$1

    while [ 1 ]
    do 
        local state=$(mmValidateWord $variable)

        if [ $state == 0 ]
        then 
            echo "Wrong format, must start with uppercase letter at least 3 letter"
            echo "Try again"
            read variable
        else
            break
        fi
    done
}

function PassIfCorrectForPesel()
{
    local variable=$1

    while [ 1 ]
    do 
        local state=$(mmValidateNumber $variable 11)

        if [ $state == 0 ]
        then 
            echo "Wrong format pesel must contain 11 digits "
            echo "Try again"
            read variable
        else
            break
        fi
    done
}

function PassIfCorrectForMonth()
{
    local variable=$1

    while [ 1 ]
    do 
        local state=$(mValidateMonth $variable 2)

        if [ $state == 0 ]
        then 
            echo "Wrong format , you can take only per years for example 12 24 36 "
            echo "Try again"
            read variable
        else
            break
        fi
    done
}


function PassIfCorrectForPhone()
{
    local variable=$1

    while [ 1 ]
    do 
        local state=$(mmValidateNumber $variable 9)

        if [ $state == 0 ]
        then 
            echo "Wrong format phone number must contain 9 digits "
            echo "Try again"
            read variable
        else
            break
        fi
    done
}

function countRRSO
{
    local cost=$1
    local storage
    local rrso=$(echo "9 / 100 "|bc -l)
    local bankReturn

    storage=$(echo "$cost * $rrso"|bc -l)
    
    bankReturn=$(echo "$cost + $storage"|bc -l)

    echo $bankReturn

}

#wez funkcje z card_and_tel_payments
function mDisplayChoice
{
    echo "1) Back to sub-menu"
    echo "2) Back to menu"
}

function Leasing()
{

    touch leasing_formulas.txt

    while [ 1 ]
do

    echo "1) Leasing Info "
    echo "2) Add form"

    local pick 
    read pick 

    mmValidatePick $pick

    case $pick in 

        "1")    
            mShowFromLeasing
            
            mDisplayChoice

            read pick 
            mmValidatePick $pick 

            if [ $pick -eq 2 ]
            then 
                break
            fi 

        ;;

        "2") 
            local name
            local surname
            local pesel 
            local phone
            local month 
            local bankReturn 
            local cost

            read -p "Name: " name 
            passIfCorrectForWord $name
            
            read -p "Suranme: " surname
            passIfCorrectForWord $surname

            read -p "Pesel : " pesel
            PassIfCorrectForPesel $pesel

            read -p "Phone: " phone
            PassIfCorrectForPhone $phone

            read -p "Month: " month
            PassIfCorrectForMonth $month

            read -p "For what kind of cost do you wanna take leasing: " cost

            bankReturn=$(countRRSO $cost)

            printf "%s\n" "Name: $name " >> leasing_formulas.txt
            printf "%s\n" "Surname: $surname " >> leasing_formulas.txt
            printf "%s\n" "Pesel: $pesel " >> leasing_formulas.txt
            printf "%s\n" "Phone: $phone " >> leasing_formulas.txt
            printf "%s\n" "Time of leasing: $month months " >> leasing_formulas.txt
            printf "%s\n" "Leasing taken: $cost PLN" >> leasing_formulas.txt
            printf "%s\n" "Cost that need to be returen to the bank(RRSO 9%): $bankReturn PLN  " >> leasing_formulas.txt
            echo "########################################" >> leasing_formulas.txt

            mDisplayChoice

            read pick 
            mmValidatePick $pick 

            if [ $pick -eq 2 ]
            then 
                break
            fi 
        ;;

    esac 
done 

}

