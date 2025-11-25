FROM python:3.9

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt --no-cache-dir

COPY manage.py .
COPY myproject/ ./myproject/  # замените на имя вашего Django-проекта
COPY static/ ./static/
COPY media/ ./media/

# При старте контейнера запустить сервер разработки.
CMD ["python", "manage.py", "runserver", "0:8000"]