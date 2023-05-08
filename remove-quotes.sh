#!/bin/bash

# Проверка наличия аргумента (имени файла)
if [ -z "$1" ]; then
  echo "Ошибка: не указан файл"
  exit 1
fi

# Проверка наличия файла
if [ ! -f "$1" ]; then
  echo "Ошибка: файл не найден"
  exit 1
fi

# Считывание содержимого файла в переменную
file_content=$(cat "$1")

# Удаление кавычек " из содержимого файла
file_content_without_quotes=$(echo "$file_content" | tr -d "\"")

# Перезапись файла с удаленными кавычками "
echo "$file_content_without_quotes" > "$1"

echo "Кавычки \" успешно удалены из файла $1"
# /home/vinod/Документи/title-maker/remove-quotes.sh
# /home/vinod/Документи/title-maker/out/titles.en.20230419.01.csv
# ./get-title.sh ./feeds/keywords-for-titles.en.04   
# и так далее
# ./remove-quotes.sh ./out/titles.en.20230419.01.csv