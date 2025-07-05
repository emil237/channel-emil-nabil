#!/bin/sh
#
# Command:
# wget https://raw.githubusercontent.com/emil237/channel-emil-nabil/main/installer.sh -qO - | /bin/sh
#
# ###########################################

MY_URL="https://raw.githubusercontent.com/emil237/channel-emil-nabil/main"

echo "******************************************************************************************************************"
echo "        DOWNLOAD AND INSTALL CHANNEL"
echo "=================================================================================================================="

#####################################################################################
echo "        INSTALLING ASTRA-SM PATCH"
opkg install astra-sm -y >/dev/null 2>&1
opkg install dvbsnoop -y >/dev/null 2>&1
sleep 1

echo "        DOWNLOADING ABERTIS SCRIPT"
wget -qO /etc/astra/scripts/abertis "https://drive.google.com/uc?id=1B0k60UTtmrHgQTrRkI6SFR3TenCZO_eL&export=download"
chmod 755 /etc/astra/scripts/abertis
sleep 1

echo "        DOWNLOADING ASTRA CONFIG"
wget -qO /etc/astra/astra.conf "https://drive.google.com/uc?id=1B16pdta4o2u_PChUAG1hEAWKj1So2vCh&export=download"
chmod 755 /etc/astra/astra.conf
sleep 1

echo ""
echo "        INSTALLING CHANNEL FILES..."
cd /tmp
set -e
wget -q "${MY_URL}/channels_backup_by_Emil-Nabil.tar.gz"
tar -xzf channels_backup_by_Emil-Nabil.tar.gz -C /
cd ..
set +e
rm -f /tmp/channels_backup_by_Emil-Nabil.tar.gz
sleep 2

echo ""
echo ""
echo "****************************************************************************************************************************"
echo "#       CHANNEL INSTALLED SUCCESSFULLY       #"
echo "*********************************************************"
echo "********************************************************************************"
echo "   UPLOADED BY >>>> EMIL_NABIL"
sleep 4
echo "========================================================================================================================="

###########################################
# Detect system type
if [ -f /etc/opkg/opkg.conf ]; then
    OSTYPE="Opensource"
else
    OSTYPE="DreamOS"
fi

# Restart Enigma2 based on system type
echo "**********************************************************************************"
echo "        >>>> RESTARTING <<<<"
echo "**********************************************************************************"

if [ "$OSTYPE" = "Opensource" ]; then
    killall -9 enigma2
else
    systemctl restart enigma2 || init 6
fi

exit 0


