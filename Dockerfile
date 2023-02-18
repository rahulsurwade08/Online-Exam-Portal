FROM python:3.12.0a5-alpine

RUN pip install --upgrade pip

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt .

RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev

RUN pip install psycopg2
RUN pip install psycopg2-binary

RUN apk add --no-cache jpeg-dev zlib-dev
RUN apk add --no-cache --virtual .build-deps build-base linux-headers \
    && pip install Pillow

RUN pip install -r requirements.txt

COPY . /app

WORKDIR /app

COPY ./entrypoint.sh /
ENTRYPOINT ["sh", "/entrypoint.sh"]

