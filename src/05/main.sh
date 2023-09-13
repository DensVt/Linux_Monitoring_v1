#!/bin/bash

# Проверка наличия параметра
if [ -z "$1" ]; then
    echo "The path is missing."
    exit 1
fi

# Проверка наличия '/' в конце пути
if [[ "$1" != */ ]]; then
    echo "The path should end with a '/'"
    exit 1
fi

DIR="$1"

# Замер времени
START_TIME=$(date +%s.%N)

# Общее число папок
TOTAL_FOLDERS=$(find "$DIR" -type d | wc -l)
echo "Total number of folders (including all nested ones) = $TOTAL_FOLDERS"

# Топ 5 папок по размеру
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
du -sh "$DIR"/* | sort -hr | head -n 5

# Общее число файлов
TOTAL_FILES=$(find "$DIR" -type f | wc -l)
echo "Total number of files = $TOTAL_FILES"

# Число различных типов файлов
CONF_FILES=$(find "$DIR" -type f -name "*.conf" | wc -l)
TEXT_FILES=$(find "$DIR" -type f -name "*.txt" | wc -l)
EXEC_FILES=$(find "$DIR" -type f -executable | wc -l)
LOG_FILES=$(find "$DIR" -type f -name "*.log" | wc -l)
ARCH_FILES=$(find "$DIR" -type f -name "*.tar" -o -name "*.gz" | wc -l)
SYMLINKS=$(find "$DIR" -type l | wc -l)

echo "Number of:"
echo "Configuration files (with the .conf extension) = $CONF_FILES"
echo "Text files = $TEXT_FILES"
echo "Executable files = $EXEC_FILES"
echo "Log files (with the extension .log) = $LOG_FILES"
echo "Archive files = $ARCH_FILES"
echo "Symbolic links = $SYMLINKS"

# Топ 10 файлов по размеру
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
find "$DIR" -type f -exec du -h {} + | sort -hr | head -n 10

# Топ 10 исполняемых файлов по размеру с MD5
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
find "$DIR" -type f -executable -exec du -h {} + | sort -hr | head -n 10 | awk '{print $2}' | xargs -I {} md5sum {}

# Время выполнения
END_TIME=$(date +%s.%N)
ELAPSED=$(echo "$END_TIME - $START_TIME" | bc)
echo "Script execution time (in seconds) = $ELAPSED"
