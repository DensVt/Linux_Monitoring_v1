#!/bin/bash

# Проверка на количество переданных параметров. Должен быть ровно один.
if [ "$#" -ne 1 ]; then
    echo "Пожалуйста, передайте один параметр."
    exit 1 # Завершение скрипта с кодом 1, если условие не выполнено
fi

if [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Некорректный ввод: введено число."
    exit 2 # Завершение скрипта с кодом 2, если условие не выполнено
fi

# Вывод значения переданного параметра.
echo $1
