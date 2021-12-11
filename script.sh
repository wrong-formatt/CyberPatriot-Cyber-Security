#!/bin/bash

mkdir -p ~/Desktop/backup
chmod 777 ~/Desktop/backup
echo Backup Folder Successful

cp /etc/group ~/Desktop/backup
cp /etc/passwd ~/Desktop/backup
echo Backup /etc/group & /etc/passwd Successful

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
            $pw | passwd ${users[$i]}
            echo ${users[$i]} password changed to $pw
        else
            echo ${users[$i]} password unchanged
        fi
    fi
done
