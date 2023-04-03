from flask import Flask, jsonify
import os
import requests
import pymongo
from apscheduler.schedulers.background import BackgroundScheduler
import hvac


app = Flask(__name__)

vault_token = os.environ.get('VAULT_TOKEN')
vault_url = os.environ.get('VAULT_URL')

vault_client = hvac.Client(
    url=vault_url,
    token=vault_token,
)

read_response = client.secrets.kv.read_secret_version(path='/spring')
mongo_uri = read_response['data']['data']['spring.data.mongodb.uri']

client = pymongo.MongoClient(mongo_uri)
parsedUri = pymongo.uri_parser.parse_uri(mongo_uri)
db = client[parsedUri['database']]


@app.route('/health')
@app.route('/')
def home():
    return jsonify("I'm alive")


def load_report():
    response = requests.get("https://d5dg7f2abrq3u84p3vpr.apigw.yandexcloud.net/report")
    db.report.insert_one(response.json())
    print("Inserted a new report to the database: " + response.text)


if __name__ == "__main__":
    sched = BackgroundScheduler(daemon=True)
    sched.add_job(load_report, 'interval', minutes=5)
    sched.start()
    load_report()
    app.run(host='0.0.0.0', debug=True, port=os.environ.get('REPORT_PORT'), use_reloader=False)
