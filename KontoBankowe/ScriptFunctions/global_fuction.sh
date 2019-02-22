 #!/bin/bash

source $(dirname $0)/globalVariables.sh 
source $(dirname $0)/globalVariablesFunctions.sh
source $(dirname $0)/menu_offers.sh
source $(dirname $0)/KservicesMenu.sh
source $(dirname $0)/finanse.sh
source $(dirname $0)/config.sh
source $(dirname $0)/cFunctionalities.sh

function greeting()
{
cSetupGlobalVariables
clear
echo "                   HELLO WELCOME IN OUR SMKM-INTERNATIONALBANK"
echo "    ########################################################################"
echo "              1) FINANCES  2) SERVICES  3) OFFER  4) MAKE TRANSACTIONS   "
echo " BALANCE:" $balance "PLN "
echo " SAVINGS: $savings PLN"
echo " ENTIRE BALANCE: $entire_balance PLN"
}

function changing()
{
local snumber
read -rsn1 snumber
while [[ $snumber -gt 5 ||  ! $snumber =~ ^[1-5]+$ ]] 
do
if [[ "$number" -lt 5 && $snumber =~ ^[1-5]+$ ]] #
then
echo ""
else
echo "Could you pick again"
fi
read -rsn1 snumber
done
case "$snumber" in
1) 
menu1
;;
2)
greetingServices
menuServices
;;
3)
MenuOffersDisplay
MenuOffer
;;
4)
cTransfersGeneralMenu
;;
esac
greeting
changing
}