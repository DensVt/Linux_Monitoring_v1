#!/bin/bash

# Определение функции get_stats, которая собирает статистику о системе
get_stats() {
    # Получение имени хоста
    HOSTNAME=$(hostname) 
    # Получение часового пояса и UTC смещения
    TIMEZONE=$(printf "%s UTC %s" "$(cat /etc/timezone)" "$(date +"%-:::z")")
    # Получение имени текущего пользователя
    USER=$(whoami)
    # Получение названия и версии операционной системы
    OS_NAME=$(grep "NAME=" /etc/os-release | head -1 | cut -d'=' -f2 | tr -d '"')
    OS_VERSION=$(grep "VERSION=" /etc/os-release | head -1 | cut -d'=' -f2 | tr -d '"' | tr -d '(' | tr -d ')')
    OS="$OS_NAME $OS_VERSION"
    # Получение текущей даты и времени
    DATE=$(date +"%d %B %Y %H:%M:%S")
    # Получение времени работы системы
    UPTIME=$(uptime -p | sed 's/up //')
    # Получение времени работы системы в секундах
    UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}' | cut -d'.' -f1)
    # Получение IP-адреса
    IP=$(hostname -I | cut -d' ' -f1) 
    # Получение маски подсети  
    MASK=$(ip a | ipcalc "$IP" | grep "^Netmask" | awk '{print $2}')
    # Получение адреса шлюза
    GATEWAY=$(ip route | awk '/default/ {print $3}')
    
    # Вывод собранных данных
    echo "HOSTNAME = $HOSTNAME"
    echo "TIMEZONE = $TIMEZONE"
    echo "USER = $USER"
    echo "OS = $OS"
    echo "DATE = $DATE"
    echo "UPTIME = $UPTIME"
    echo "UPTIME_SEC = $UPTIME_SEC"
    echo "IP = $IP"
    echo "MASK = $MASK"
    echo "GATEWAY = $GATEWAY"

    # Сбор и вывод данных о памяти
    Mem=($(free -b | grep Mem))
    echo -n "RAM_TOTAL = "; echo -n $(echo "scale=3;x=${Mem[1]}/1073741824; if(x<1) print 0; x" | bc); echo " GB"
    echo -n "RAM_USED = "; echo -n $(echo "scale=3;x=${Mem[2]}/1073741824; if(x<1) print 0; x" | bc); echo " GB"
    echo -n "RAM_FREE = "; echo -n $(echo "scale=3;x=${Mem[3]}/1073741824; if(x<1) print 0; x" | bc); echo " GB"
    
    # Сбор и вывод данных о дисковом пространстве
    Space=($(df -B1 / | grep /))
    echo -n "SPACE_ROOT = "; echo -n $(echo "scale=2;x=${Space[1]}/1048576; if(x<1) print 0; x" | bc); echo " MB"
    echo -n "SPACE_ROOT_USED = "; echo -n $(echo "scale=2;x=${Space[2]}/1048576; if(x<1) print 0; x" | bc); echo " MB"
    echo -n "SPACE_ROOT_FREE = "; echo -n $(echo "scale=2;x=${Space[3]}/1048576; if(x<1) print 0; x" | bc); echo " MB"
}
