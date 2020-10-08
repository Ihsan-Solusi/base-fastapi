FROM python:3.8-alpine3.10

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

COPY ./gunicorn_conf.py /gunicorn_conf.py

COPY ./start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

COPY ./app /app
WORKDIR /app/

# Copy poetry.lock* in case it doesn't exist in the repo
COPY ./app/pyproject.toml ./app/poetry.lock* /app/

ENV PYTHONPATH=/app \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  POETRY_VERSION=1.1.0 \
  INSTALL_DEV=false

RUN apk add --no-cache --virtual .build-deps gcc libc-dev make \
        build-base openssl-dev libffi-dev \
        libxml2-dev libxslt-dev postgresql-dev \
        postgresql-client netcat-openbsd curl git \
    && pip install --no-cache-dir uvicorn gunicorn \
    && pip install "poetry==$POETRY_VERSION" \
    && poetry config virtualenvs.create false \
    && poetry install --no-root --no-dev \
    && apk del .build-deps gcc libc-dev make \
        build-base openssl-dev libffi-dev \
        libxml2-dev libxslt-dev postgresql-dev

EXPOSE 80

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Gunicorn with Uvicorn
CMD ["/start.sh"]