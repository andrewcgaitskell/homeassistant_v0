import logging
import sys

from flask import Flask
from flask_mqtt import Mqtt

app = Flask(__name__)

app.config['MQTT_BROKER_URL'] = 'mosquitto'
app.config['MQTT_BROKER_PORT'] = 8080  # default port for non-tls connection
app.config['MQTT_TRANSPORT'] = 'websockets' 
app.config['MQTT_KEEPALIVE'] = 10  # set the time interval for sending a ping to the broker to 10 seconds
app.config['MQTT_TLS_ENABLED'] = False
app.config['MQTT_CLIENT_ID'] = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

app.logger.setLevel(logging.DEBUG)
mqtt = Mqtt(app, mqtt_logging=True)

print("print")  # works
@mqtt.on_message()
def handle_mqtt_message(client, userdata, message):
    data = dict(
        topic=message.topic,
        payload=message.payload.decode("utf-8")
    )
    app.logger.info(data)  # works
    print(data)  # doesn't work


@app.route('/webhook', methods=['POST'])
def webhook():
    message = "A new entry was created!"
    app.logger.info(message)  # works
    print(message) # doesn't work
    mqtt.publish('DIRECTUS', bytes(message, 'utf-8'))
    return "", 200


@mqtt.on_connect()
def handle_connect(client, userdata, flags, rc):
    mqtt.subscribe('DIRECTUS')


@mqtt.on_log()
def handle_logging(client, userdata, level, buf):
    print('LOG: {}'.format(buf))  # works? For some reason?


app.run(host="app", port=8080, use_reloader=False, debug=True)
