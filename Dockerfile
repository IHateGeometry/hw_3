FROM python:3.12

COPY app/requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

COPY ./app /app
WORKDIR /app
CMD ["python", "app.py"]
