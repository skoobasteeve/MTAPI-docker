FROM python:3.9-alpine
WORKDIR /app

LABEL com.skoobasteeve.mtapi-docker.version="main"

ADD MTAPI .
COPY data/stations.json data/
COPY data/stations.csv data/

RUN pip install -r requirements.txt

CMD [ "python", "app.py" ]
EXPOSE 5000
