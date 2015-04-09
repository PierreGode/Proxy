#!/bin/bash
start()
{
if [[ ! -x /etc/squid3 ]];then
      echo -e "$warn\ninstalling Squid server"
      sudo apt-get install squid3 -y
      else 
	  clear
	 
	  echo "                              Squid proxyserver is already installed          "
     while true; do
     read -p 'Do you really want to continue with this setup? all previous information will be lost! (y/n)?' yn
   case $yn in
    [Yy]* ) echo ""
	        break;;
    [Nn]* ) echo "Exiting Setup"
            sleep 2        
            exit ;;
    * ) echo 'Please answer yes or no.';;
   esac
done
fi
sudo apt-get install apache2-utils -y
sudo apt-get install curl -y
clear
echo "          Configurating....          "
sudo touch /etc/squid3/squid-passwd
sudo chmod o+r /etc/squid3/squid-passwd

echo "          Type in new login user for Squid proxy server          "
read user
htpasswd /etc/squid3/squid-passwd $user
echo "          Getting conf file from server          "
wget http://www.webbhatt.com/databas/squid.conf
sudo cat squid.conf > /etc/squid3/squid.conf
echo "          Wait for service to start....          "
sudo service squid3 restart
sleep 1
clear
echo "  Remember to open port 3128 on firewall or portforward "
echo "Printing Public IP... "
curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
sleep 5
exit
}
start
