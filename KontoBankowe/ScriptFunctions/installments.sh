#!/bin/bash


function igetting()
{

local -a products=()
    local index=0

    while read -r line 
    do
       products[$index]="$line"
        let index++
		echo "$index"
    done < "installments.txt"

    local -a nameofProduct=()
    local -a nameOfProductCompany=()
	local -a entirePrice=()
	local -a installmentPerPeriod=()
   

    for (( i=0; i<$index; i++ ))
    do
       product=(${products[$i]})

      nameofProduct[$i]=${product[0]}
       nameOfProductCompany[$i]=${product[1]}
		entirePrice[$i]=${product[2]}
		  installmentPerPeriod[$i]=${product[3]}
        
    done

    for (( i=0;  i<$index;  i++ ))
    do
	   echo "Your installments" $(($i+1))":"
        echo "Product:" ${nameofProduct[$i]}
        echo "Company:" ${nameOfProductCompany[$i]}
		echo "Entire Price:" ${entirePrice[$i]}
		echo "Period installment:" ${installmentPerPeriod[$i]}
        echo ""
    done
}
####################################################################################################
function ichanging()
{
echo "            YOU CAN CHECK YOUR  INSTALLMENTS (1)    BACK  (2) "

local snumber
read snumber
while [[ $snumber -gt 2 ||  ! $snumber =~ ^[1-2]+$ ]] 
do
if [[ "$number" -lt 2 && $snumber =~ ^[1-2]+$ ]] #
then
echo ""
else
echo "Could you pick again"
fi
read snumber
done
case "$snumber" in
1) 
sleep 1
 igetting
 sleep 1
 ichanging
;;
2)
sleep 1
echo "back"
;;

esac
}
