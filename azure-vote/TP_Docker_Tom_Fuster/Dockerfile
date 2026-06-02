# -- Stage 1: Build dependencies --
FROM python:3.13-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


FROM python:3.13-slim

LABEL maintainer="voting-app"
LABEL description="Azure Voting App - Python Flask + Redis"

WORKDIR /app


COPY --from=builder /install /usr/local


COPY azure-vote/ /app/


ENV REDIS="redis" \
    REDIS_PWD=""

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:80/')" || exit 1

CMD ["python", "main.py"]
