#!/bin/bash

source $(dirname $0)/globalVariables.sh 

function getcash()
{

echo "How much money you want to top up your phone"
read topUp
while [[ $topUp -gt $balance    ||   ! $topUp =~ ^[0-9]+$ ]]
do
if [[ $topUp -lt $balance  ]] && [[  $topUp =~ ^[0-9]+$ ]]
then
echo "DONE !!"
else 
echo "you dont have money"
fi
read topUp
done
((balance-=$topUp))

 echo " Now on your account you have $balance $"
 sed -i "1d" ./balance.txt
 echo "$balance" >> balance.txt
 echo
  }
  function tchoose()
  {
  clear
 echo "                   TELEPHONE TOP UP(1)    BACK(2)   "
 echo " BALANCE : $balance PLN"
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
getcash
sleep 1
tchoose
;;
2)
sleep 1
echo "back"
;;
esac
  }
