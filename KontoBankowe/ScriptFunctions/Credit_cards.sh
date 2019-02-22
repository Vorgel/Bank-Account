#!/bin/bash
 
source $(dirname $0)/globalVariables.sh 

 debit_card=$(head -n 1 d_card.txt)
function withhold()
{
if [[ $debit_card -eq 0 ]]
then
echo " you can delete your card because you do not have any"
else

sed -i "1d" ./d_card.txt
printf "%s" "0 " >> d_card.txt
debit_card=$(head -n 1 d_card.txt)
echo "deleted"
 fi
}
function newdebit()
{
new_card=$(shuf -i1000000000000000-9999999999999999 -n1)
if [[ $debit_card -eq 0 ]]
then
echo " Your account blance has been decreased by 10 PLN"
echo " NEW numer od card : $new_card "
sed -i "1d" ./d_card.txt
printf  "$new_card " >> d_card.txt
debit_card=$(head -n 1 d_card.txt)
((balance-=10))
sed -i "1d" ./balance.txt
echo "$balance" >> balance.txt
balance=$(head -n 1 balance.txt)
 
else
echo "You cannot have more than 1 debit card "
 fi
}
function addingCards()
{
echo " "
echo "        withhold debit card  (1)  add debit card when you dont have (2)   "
echo "                                    back(3)"
 local snumber
read snumber
while [[ $snumber -gt 3 ||  ! $snumber =~ ^[1-3]+$ ]] 
do
if [[ "$snumber" -lt 3 && $snumber =~ ^[1-3]+$ ]] #
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
 withhold
sleep 1
 addingCards
;;
2)
sleep 1
newdebit
sleep 1
addingCards
;;

3)
sleep 1
cchanging
;;
esac
 
}

function cchanging()
{
echo "                            MANAGE(1)   BACK(2)  "
echo "BALANCE: $balance PLN"
if [[ $debit_card -ne 0 ]]
then
echo "YOUR debit card: $debit_card"
else
echo "You do not have debit card"
fi
local snumber
read snumber
while [[ $snumber -gt 2 ||  ! $snumber =~ ^[1-2]+$ ]] 
do
if [[ "$snumber" -lt 2 && $snumber =~ ^[1-2]+$ ]] #
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

addingCards

;;
2)
menu1
;;

esac
}
function menu4()
{
cchanging
}
