#!/bin/bash

# Объявление ассоциативных массивов для кодов цветов фона и текста
declare -A colors
colors[1]="\e[47m" # white
colors[2]="\e[41m" # red
colors[3]="\e[42m" # green
colors[4]="\e[44m" # blue
colors[5]="\e[45m" # purple
colors[6]="\e[40m" # black

declare -A text_colors
text_colors[1]="\e[97m"
text_colors[2]="\e[91m"
text_colors[3]="\e[92m"
text_colors[4]="\e[94m"
text_colors[5]="\e[95m"
text_colors[6]="\e[90m"

# Проверка на совпадение цветов фона и текста для каждого столбца
if [[ "$1" == "$2" || "$3" == "$4" ]]; then
    echo -e "\e[91mОшибка: Цвета фона и текста одного столбца не должны совпадать. Пожалуйста, повторно вызовите скрипт с другими параметрами.\e[0m"
    exit 1
fi

# Функция для получения статистики о системе с применением выбранных цветов
get_stats_colored() {
    local label_bg="${colors[$1]}"
    local label_fg="${text_colors[$2]}"
    local value_bg="${colors[$3]}"
    local value_fg="${text_colors[$4]}"

    # Массив с метками для выводимых данных
    labels=("HOSTNAME" "TIMEZONE" "USER" "OS" "DATE" "UPTIME" "UPTIME_SEC" "IP" "MASK" "GATEWAY" "RAM_TOTAL" "RAM_USED" "RAM_FREE" "SPACE_ROOT" "SPACE_ROOT_USED" "SPACE_ROOT_FREE")
    
    # Заполнение массива values данными, полученными из функции get_stats
    mapfile -t values < <(get_stats)

    local output=""
    # Сборка строки для вывода
    for i in "${!labels[@]}"; do
        output+="${label_bg}${label_fg}${labels[$i]}\e[0m = ${value_bg}${value_fg}${values[$i]}\e[0m\n"
    done
    echo -e "$output"
}
