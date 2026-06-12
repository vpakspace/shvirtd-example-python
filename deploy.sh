#!/usr/bin/env bash
# Задача 4: разворачивание проекта на облачной ВМ.
# Скачивает fork-репозиторий в /opt и поднимает весь проект через docker compose.
set -euo pipefail

REPO_URL="https://github.com/vpakspace/shvirtd-example-python.git"
TARGET_DIR="/opt/shvirtd-example-python"

# Клонируем (или обновляем) репозиторий в /opt.
sudo mkdir -p /opt
if [ -d "${TARGET_DIR}/.git" ]; then
    echo ">>> Репозиторий уже есть, обновляю..."
    sudo git -C "${TARGET_DIR}" pull --ff-only
else
    echo ">>> Клонирую репозиторий в ${TARGET_DIR}..."
    sudo git clone "${REPO_URL}" "${TARGET_DIR}"
fi

# Поднимаем проект целиком.
cd "${TARGET_DIR}"
sudo docker compose up -d --build

echo ">>> Готово. Проверка: curl -L http://127.0.0.1:8090"
sudo docker compose ps
