#!/bin/bash
echo $TESTVAR
echo "/etc/issue is $(cat /etc/issue)"

# Грубовато, но задачу решает:
echo "Server hostname is $(cat /etc/hostname)"

#Или так. В файле compose её прописывать не нужно:
#echo Server hostname is $HOSTNAME"


#Ждём, когда отработает команда в контейнере clientbox
sleep 2
echo "Client hostname is $(cat /home/client_id.txt)"
