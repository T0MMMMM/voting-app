FROM docker.io/python:3.13

ADD /azure-vote /app
WORKDIR /app
RUN pip install -r requirements.txt

EXPOSE 5000
CMD ["python", "main.py"]
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1