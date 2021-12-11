#!/bin/bash

mkdir -p ~/Desktop/backup
chmod 777 ~/Desktop/backup
echo Backup Folder Successful

cp /etc/group ~/Desktop/backup
cp /etc/passwd ~/Desktop/backup
echo Backup /etc/group and /etc/passwd successful

rm /var/lib/dpkg/lock-frontend
rm /var/lib/dpkg/lock
echo apt lock is disabled.  Package downloading enabled.

apt-get install ufw
ufw enable
echo Firewall enabled

echo Enter all users required by CyberPatriot, separated by a space
read -a users

usersLen=${#users[@]}

for ((i = 0; i < $usersLen; i++)) do
    clear
    echo ${users[$i]}
    echo Delete ${users[$i]}? yes or no
    read del
    if [[ $del == yes ]]; then
        deluser ${users[$i]}
        echo ${users[$i]} deleted
    else
        echo Is ${users[$i]} admin or user?
        read adm
        if [[ $adm == admin ]]; then
            adduser ${users[$i]} adm
            echo ${users[$i]} is now an admin
        elif [[ $adm == user ]]; then
            deluser ${users[$i]} adm
            echo ${users[$i]} is now a user
        fi
        echo Set user password? yes or no
        read ynpswd
        if [[ $ynpswd == yes ]]; then
            echo Password:
            read pw
            echo -e "$pw\n$pw" | passwd ${users[$i]}
            echo ${users[$i]} password changed to $pw
        else
            echo ${users[$i]} password unchanged
        fi
    fi
done
clear

echo Enter new users required by CyberPatriot, separated by a space
read -a nusers

nusersLen=${#nusers[@]}

for((i = 0; i < $nusersLen; i++)) do
    clear
    echo ${nusers[$i]}
    echo Password:
    read npw
    echo -e "$npw\n$npw" | adduser ${nusers[$i]}
    echo ${nusers[$i]} password set to $npw
    clear
    echo Is ${nusers[$i]} admin or user?
    read nadm
    if [[ $nadm == admin ]]; then
        adduser ${nusers[$i]} adm
        echo ${nusers[$i]} is now an admin
    else
        echo ${nusers[i]} is now a user
    fi
done
clear

echo Does the system allow media files? yes or no
read answer

if [[ $answer == no ]]; then
    find /home -name *.jpg | xargs rm
    find /home -name *.png | xargs rm
    find /home -name *.mp4 | xargs rm
	find /home -name *.mp3 | xargs rm
	find /home -name *.wav | xargs rm
	find /home -name *.aiff | xargs rm
    find /home -name *.gif | xargs rm
    find /home -name *.tiff | xargs rm
    find /home -name *.jpeg | xargs rm
    find /home -name *.mov | xargs rm
    find /home -name *.flv | xargs rm
    find /home -name *.mpg | xargs rm
    find /home -name *.mpeg | xargs rm
fi
echo All media files within home directory have been removed
clear

echo Deleting shady packages...
dpkg --get-selections | grep "sniff" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "crack" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "brute force" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "hack" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "game" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "backdoor" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "john" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "netcat" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "hydra" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "telnet" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "ophcrack" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "kismet" | cut -f1 | xargs apt-get autoremove --purge -y
dpkg --get-selections | grep "medusa" | cut -f1 | xargs apt-get autoremove --purge -y
echo All hacking tools and dangerous software have been cleaned
clear

echo End of script
