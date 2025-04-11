# Используем базовый образ с Python
FROM python:3.10-slim

# Устанавливаем зависимости для сборки
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Устанавливаем Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY . .

# Устанавливаем зависимости через Poetry
RUN poetry config virtualenvs.create false && poetry install --extras "full"

# Открываем порт для сервера
EXPOSE 8000

# Команда запуска
CMD ["poetry", "run", "marker_server", "--host", "0.0.0.0", "--port", "8000"]