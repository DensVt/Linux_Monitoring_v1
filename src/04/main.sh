#!/usr/bin/env bash

# Функция для преобразования числового значения в название цвета
color_name() {
    case "$1" in
        1) echo "white" ;;
        2) echo "red" ;;
        3) echo "green" ;;
        4) echo "blue" ;;
        5) echo "purple" ;;
        6) echo "black" ;;
        *) echo "unknown" ;;
    esac
}

# Значения по умолчанию для различных параметров
default_column1_background=6
default_column1_font_color=1
default_column2_background=2
default_column2_font_color=4

# Чтение файла конфигурации
config_file="conf"
if [ -f "$config_file" ]; then
    source "$config_file"
fi

# Присвоение переменных значениями по умолчанию, если они не установлены
column1_background=${column1_background:-$default_column1_background}
column1_font_color=${column1_font_color:-$default_column1_font_color}
column2_background=${column2_background:-$default_column2_background}
column2_font_color=${column2_font_color:-$default_column2_font_color}

# Запуск основного скрипта
source run.sh "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"

echo ""

# Функция для отображения информации о цвете
display_color_info() {
    local color_value=$1
    local default_value=$2

    if [ "$color_value" == "$default_value" ]; then
        echo -n "default ($(color_name $default_value))"
    else
        echo -n "${color_value} ($(color_name $color_value))"
    fi
}

# Вывод информации
echo -n "Column 1 background = "
display_color_info "$column1_background" "$default_column1_background"
echo ""

echo -n "Column 1 font color = "
display_color_info "$column1_font_color" "$default_column1_font_color"
echo ""

echo -n "Column 2 background = "
display_color_info "$column2_background" "$default_column2_background"
echo ""

echo -n "Column 2 font color = "
display_color_info "$column2_font_color" "$default_column2_font_color"
echo ""
