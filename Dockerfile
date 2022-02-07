FROM python:3.9-slim as base
RUN mkdir /project
WORKDIR /project
COPY app.py .
COPY requirements.txt .
RUN pip install -r requirements.txt
CMD gunicorn -k uvicorn.workers.UvicornWorker --bind=0.0.0.0:80 app:app
