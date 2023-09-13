#!/usr/bin/env bash

source conf # Импорт конфигурационного файла и других скриптов
source stats.sh
source color_translator.sh 

# Получение данных о системе с применением цветов из конфигурационного файла
data=$(get_stats_colored "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color")
echo -e "$data\n" # Вывод данных
