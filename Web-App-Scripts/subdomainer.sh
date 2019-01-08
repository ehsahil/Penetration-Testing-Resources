#!/bin/bash

: '
REQUIREMENTS:
sublist3r.py (https://github.com/aboul3la/Sublist3r)

API-dnsdumpster.com (https://github.com/PaulSec/API-dnsdumpster.com)
The "API_example.py" file found within the dnsdumpster folder must be modified to take a URL as the first argument. 
CHANGE: domain = "uber.com"
TO: 	domain = sys.argv[1] #with "import sys" added

vt-subdomains.py (https://github.com/chris408/virustotal-subdomain-scraper)
please note that this will also require an API key from VirusTotal which can be gained by signing up for an account at https://www.virustotal.com/#/join-us. This API key will need to be added as an environment variable before running the script.

crtsh_enum_web.py (https://github.com/appsecco/the-art-of-subdomain-enumeration/blob/master/crtsh_enum_web.py)

amass (https://github.com/OWASP/Amass)
'

echo -e "\n\e[00;31m#########################################################\e[00m" 
echo -e "\e[00;31m#\e[00m" "\e[00;33mSub-Domain Enumeration Script\e[00m" "\e[00;31m#\e[00m"
echo -e "\e[00;31m#########################################################\e[00m"
echo -e "\e[00;33m# www.twitter.com/cxosmo\e[00m"
echo -e "\e[00;33m# Version 1\e[00m\n\n"

echo -e ".------..------..------..------..------..------."
echo -e "|C.--. ||X.--. ||O.--. ||S.--. ||M.--. ||O.--. |"
echo -e "| :/\: || :/\: || :/\: || :/\: || (\/) || :/\: |"
echo -e "| :\/: || (__) || :\/: || :\/: || :\/: || :\/: |"
echo -e "| '--'C|| '--'X|| '--'O|| '--'S|| '--'M|| '--'O|"
echo -e "\`------'\`------'\`------'\`------'\`------'\`------'"

usage() 
{ 
echo -e "\n\e[00;31m#########################################################\e[00m" 
echo -e "\e[00;31m#\e[00m" "\e[00;33mSub-Domain Enumeration Script\e[00m" "\e[00;31m#\e[00m"
echo -e "\e[00;31m#########################################################\e[00m"
echo -e "\e[00;33m# www.twitter.com/cxosmo\e[00m"
echo -e "\e[00;33m# Version 1\e[00m\n"

echo "OPTIONS:"
echo "-f	[REQUIRED] Enter filename containing URLs to enumerate" 
echo "-o	[REQUIRED] Enter report name to output"
echo -e "-h	Displays this help text\n\n"
echo -e "EXAMPLE: ./subdomainer.sh -f /path/to/urlfile.txt -o report.txt\n"
		
echo -e "\e[00;31m#########################################################\e[00m"

exit 1		
}

scope_file()
{
if [ "$scope_file" ]; then 
	echo -e "[+] File location for list of URLs to find sub-domains for = $scope_file\n"
else
	echo -e "ERROR: Input file required (-f flag) containing URL(s) to enumerate for sub-domains!\nERROR: Output file needs specifying (-o flag).\nEXAMPLE: ./subdomainer.sh -f /path/to/urlfile.txt -o report.txt\n"
	exit 1
fi
}

debug_info()
{
if [ "$report" ]; then
	echo -e "[+] Raw terminal output will be saved to the following file = $report\n"
	echo -e "[+] File(s) containing sub-domains only will be saved in the current directory in the following format: <URL>-subdomain\n" 
else
	echo -e "ERROR: Please specify a name for the output file!"
	exit 1
fi
}

sub_enum()
{
echo -e "\e[00;33m### SUB-DOMAIN ENUMERATION ##############################################\e[00m" 

cat $scope_file | while read line
do 

#sublist3r.py 
sublist=$(locate sublist3r.py | head -n 1)
sublist3r=`python $sublist -d $line`
echo -e "\e[00;31m[-] python sublist3r.py -d $line:\e[00m\n$sublist3r\n" 

#crtsh_enum_web.py (utilises Certificate Transparency from https://crt.sh/)
crtshenum=$(locate crtsh_enum_web.py | head -n 1)
crtexec=`python3 $crtshenum $line` 
echo -e "\e[00;31m[-] python3 crtshenum.py $line:\e[00m\n$crtexec\n" 

#vt-subdomains.py (virustotal)
vtsubdomains=$(locate vt-subdomains.py | head -n 1)
vtexec=`python3 $vtsubdomains $line` 
echo -e "\e[00;31m[-] python3 vtsubdomains.py $line:\e[00m\n$vtexec\n" 

#API_example.py (dnsdumpster)
dnsdumpster=$(locate API_example.py | head -n 1)
dnsexec=`python3 $dnsdumpster $line` 
echo -e "\e[00;31m[-] python3 dnsdumpster.py $line:\e[00m\n$dnsexec\n" 

#amass 
amass=`amass -d $line`
echo -e "\e[00;31m[-] amass -d $line:\e[00m\n$amass\n"

sed -n '/ /!p' $report >> $line-subdomains; sed -i "/$line/!d" $line-subdomains; sort $line-subdomains | uniq >> $line-subdomains2; mv $line-subdomains2 $line-subdomains

done
}

call_each()
{
  scope_file  
  debug_info
  sub_enum
}

while getopts "h:f:o:" option; do
 case "${option}" in
    f) scope_file=${OPTARG};;
    o) report=${OPTARG};;
    h) usage; exit;;
    *) usage; exit;;
 esac
done

call_each | tee -a $report 2> /dev/null
