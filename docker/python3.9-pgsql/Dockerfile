FROM python:3.9-alpine3.13

WORKDIR /app/

ENV PYTHONPATH=/app \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  INSTALL_DEV=false

ADD ./docker/python3.9-pgsql/requirements.txt .
RUN apk add --no-cache --virtual .build-deps gcc \
        libc-dev make build-base openssl-dev \
        libffi-dev libxml2-dev libxslt-dev \
        #postgresql-dev \
        musl-dev cargo \
        #postgresql-client \
    && apk add netcat-openbsd curl \
    ## Install python package with no-cache
    && pip install --no-cache-dir -r requirements.txt

# Set Timezone
RUN apk add tzdata
ENV TZ=Asia/Jakarta

# Copy folder app
COPY ./docker/app /app

# Run app command section
COPY ./docker/start.sh /start.sh
RUN chmod +x /start.sh

COPY ./docker/gunicorn_conf.py /gunicorn_conf.py

COPY ./docker/start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

EXPOSE 80

CMD ["/start.sh"]
