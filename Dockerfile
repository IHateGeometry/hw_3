FROM python:3.12
COPY ./app /app
WORKDIR /app
CMD ["python", "app.py"]
