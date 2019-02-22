#!/bin/bash
function ddeleting ()
{
 clear
 local index=0

    while read -r line 
    do
       products[$index]="$line"
        let index++
    done < "documents.txt"
	echo "You have $index number of documents you can choose one of them to deleted"
 
	numberFormat='^[0-9]+$'
    read -p "Write down a document you want do delete: " numberOfLine
	if ! [[ "$numberOfLine" =~ $numberFormat ]]  || [[  "$numberOfLine" -gt $index ]]
	then
	until [[ "$numberOfLine" =~ $numberFormat ]]  && [[  "$numberOfLine" -le $index ]]
	do
	echo "There is no line $numberOfLine"
    read numberOfLine
	done
	fi
	sed -i "${numberOfLine}d" ./documents.txt
   
}
function dadding ()
{ 
echo "WRITE ID DOWN"
 local documents 
 read documents
 
printf "%s" "$documents " >> documents.txt
echo " " >> documents.txt
}
function dgetting()
{
local -a documents=()
    local index=0

    while read -r line 
    do
       products[$index]="$line"
        let index++
    done < "documents.txt"

var=$(<documents.txt)
echo "$var"
}

function dchanging()
{
echo "        YOU CAN ADD YOUR DOCUMENTS (1)   YOU CAN SEE YOUR DOCUMENTS(2)    "
echo "                   YOU DELETE YOUR DOCUMENT(3)   BACK(4)    "

local snumber
read snumber
while [[ $snumber -gt 4 ||  ! $snumber =~ ^[1-4]+$ ]] 
do
if [[ "$snumber" -lt 4 && $snumber =~ ^[1-4]+$ ]] #
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
dadding
 sleep 1
 clear
 dchanging
;;
2)
sleep 1
dgetting

dchanging
;;
3)
sleep 1
ddeleting
dchanging
;;
4)
sleep 1
echo "back"
;;
esac
}
