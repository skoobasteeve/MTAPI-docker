FROM python:3.9-alpine
WORKDIR /app

LABEL com.skoobasteeve.mtapi-docker.version="main"

RUN apk add --no-cache git
RUN git clone https://github.com/jonthornton/MTAPI.git /app

COPY data/stations.json data/
COPY data/stations.csv data/

RUN pip install -r requirements.txt

CMD [ "flask", "run", "--host=0.0.0.0" ]
EXPOSE 5000
