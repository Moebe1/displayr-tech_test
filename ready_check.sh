#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
bold=$(tput bold)
RES=0
DOWNCOUNT=0
URL=$(terraform output -raw hello_world_link)
 while true
 do
  RES=`curl — max-time 5 -s $URL > /dev/null`
  RES=$?
  if [ $RES -eq 0 ]; then
   echo -e "${green}Website is UP! ${green}Readiness time=$DOWNCOUNT seconds${reset}"
   echo -e
   echo -e "${bold}${green}Site URL: http://$URL/index.html${reset}"
   echo -e
   exit 1
  else
   echo -e "${red}Website is DOWN! Down time=$DOWNCOUNT  seconds${reset}"
   DOWNCOUNT=$[$DOWNCOUNT+1]
  fi
 sleep 1
 done
fi
