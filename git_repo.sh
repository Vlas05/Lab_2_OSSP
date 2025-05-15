#!/bin/bash

read -p "Введіть шлях до каталогу: " DIR
read -p "Введіть URL віддаленого репозиторію: " REMOTE
read -p "Введіть ім'я гілки [default: master]: " BRANCH

# Якщо ім'я гілки не вказано — використовуємо "master"
BRANCH=${BRANCH:-master}

# Перетворення відносного шляху у абсолютний
case "$DIR" in
    /*) ;;
    *) DIR="$(pwd)/$DIR" ;;
esac

# Перевірка чи існує директорія
if ! [ -d "$DIR" ]; then
    echo "Помилка: не має такої директорії"
    exit 2
fi

cd "$DIR" || exit 2

# Ініціалізація репозиторію та пуш
git init --initial-branch="$BRANCH"
git remote add origin "$REMOTE"
git add .
git commit -m "Initial commit"
git push --set-upstream origin "$BRANCH"

exit 0
