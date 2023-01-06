FROM python:latest
ADD app /app
WORKDIR /app
RUN pip install -r requirements.txt \
    && curl https://storage.yandexcloud.net/cloud-certs/CA.pem -o YandexInternalRootCA.crt
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8080
