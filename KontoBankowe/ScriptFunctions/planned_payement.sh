#!/bin/bash
function deleting ()
{
 clear
    local name
    read -p "Write down name of payement: " name
    
	sed -i "/$name/d" ./payements.txt
   
}

function adding ()
{ 
 local date 
 echo "date of execute dd-mm-yyyy:"
 read date
date_format='^(([0-2][0-9]|(3)[0-1])-(((0)[0-9])|((1)[0-2]))-[0-9]{4})$'
# file payements is needed 
 if  ! [[ "$date" =~ $date_format ]]
then  
	until [[  "$date" =~ $date_format  ]]
	do
		echo "date of execute dd-mm-yyyy:"
		read date
	done
fi
  local name_of_payement
  echo "name of payement"
  read name_of_payement
    printf "%s" "$date " >> payements.txt
	printf "%s" "$name_of_payement " >> payements.txt
	echo ""  >> payements.txt
}

function getting()
{

local -a payements=()
    local index=0

    while read -r line 
    do
       payements[$index]="$line"
        let index++
		echo "$index"
    done < "payements.txt"

    local -a payementDate=()
    local -a payementName=()
   

    for (( i=0; i<$index; i++ ))
    do
        payement=(${payements[$i]})

       payementDate[$i]=${payement[0]}
        payementName[$i]=${payement[1]}
        
    done

    for (( i=0;  i<$index;  i++ ))
    do
	   echo "Your Planned Payements" $(($i+1))":"
        echo "Date:" ${payementDate[$i]}
        echo "Name:" ${payementName[$i]}
        echo ""
    done
}


function which ()
{
echo "  YOU CAN ADD ANOTHER PAYEMENT (1) SHOW EVERY PAYEMENT(2) DELETE PAYEMENT(3) "
echo "                                  BACK  (4)                                                                    "
local snumber
read snumber
while [[ $snumber -gt 4 ||  ! $snumber =~ ^[1-4]+$ ]] 
do
if [[ "$number" -lt 4 && $snumber =~ ^[1-4]+$ ]] #
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
adding
sleep 1
clear
 which
;;
2)
sleep 1
getting
sleep 1 
which
;;
3)
sleep 1
deleting
sleep 1
clear
 which
;;
4)
echo "back"
;;
esac
}