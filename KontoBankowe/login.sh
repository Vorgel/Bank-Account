#!/bin/bash

cd ScriptFunctions

source $(dirname $0)/global_fuction.sh

function loginscreen()
{
    sed -i -e 's/\r$//' certificates.sh

    local passwordFormat='^[0-9]+$'
    local loginFormat='^[a-zA-Z]+$'
    local loginInput1
    local passwordInput

    clear
    echo -n "Type your login: "
    read loginInput
    echo -n "Type your password: "
    read passwordInput

    if ! [[ "$loginInput" =~ $loginFormat ]] || ! [[ "$passwordInput" =~ $passwordFormat ]]
    then
        until [[ "$loginInput" =~ $loginFormat ]] && [[ "$passwordInput" =~ $passwordFormat ]]
        do
                clear
                echo "Incorrect input. Try again."
                echo -n "Type your login: "
                read loginInput
                echo -n "Type your password: "
                read passwordInput
        done
    fi
    
    greeting
    changing
}

loginscreen