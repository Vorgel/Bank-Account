#!/bin/bash

source $(dirname $0)/finanse_credits.sh
source $(dirname $0)/Credit_cards.sh
source $(dirname $0)/cFunctionalities.sh

function fgreeting()
{
  clear
  echo "Menu | Finances" 
  echo "1. Savings account" 
  echo "2. Debit-cards" 
  echo "3. Loans"
  echo "4. Back"
}

function fchanging()
{
  local snumber
  read -rsn1 snumber
  
  while [[ $snumber -gt 6 ||  ! $snumber =~ ^[1-6]+$ ]] 
  do
  	
    if [[ "$number" -lt 6 && $snumber =~ ^[1-6]+$ ]] #
 		then
  		echo ""
    else
    	echo "Could you pick again"
    fi
  
  	read -rsn1 snumber
  done
  
  case "$snumber" in
    1)
      cSavingsAccountFunctionality
      ;;
    2)
      menu4
      ;;
    3)
      finanse_c
      ;;
	  4)
      return
      ;;
  esac
  
  menu1
}

function menu1()
{
  fgreeting
  fchanging
}

