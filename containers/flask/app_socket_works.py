"""

A small Test application to show how to use Flask-MQTT.

"""
import logging

import eventlet
import json
from flask import Flask, render_template
import flask_mqtt
from flask_mqtt import Mqtt
from flask_socketio import SocketIO
from flask_bootstrap import Bootstrap


app = Flask(__name__)
app.config['MQTT_BROKER_URL'] = 'mosquitto'
app.config['MQTT_TRANSPORT'] = 'websockets'
app.config['MQTT_BROKER_PORT'] = 8080
app.config['MQTT_CLIENT_ID'] = 'flask_mqtt'
app.config['MQTT_KEEPALIVE'] = 10
app.config['MQTT_TLS_ENABLED'] = False


mqtt = flask_mqtt.Mqtt(app)
socketio = SocketIO(app, logger=True, cors_allowed_origins="*")
bootstrap = Bootstrap(app)


@app.route('/')
def index():
    return render_template('index.html')


@socketio.on('publish')
def handle_publish(json_str):
    data = json.loads(json_str)
    mqtt.publish(data['topic'], data['message'], data['qos'])
    app.logger.info("publish %s",data)  # works
    print(data)  # doesn't work


@socketio.on('subscribe')
def handle_subscribe(json_str):
    data = json.loads(json_str)
    mqtt.subscribe(data['topic'], data['qos'])
    app.logger.info("subscribe %s", data['topic'])  # works
    print(data)  # doesn't work


@socketio.on('unsubscribe_all')
def handle_unsubscribe_all():
    mqtt.unsubscribe_all()


@mqtt.on_message()
def handle_mqtt_message(client, userdata, message):
    data = dict(
        topic=message.topic,
        payload=message.payload.decode(),
        qos=message.qos,
    )
    socketio.emit('mqtt_message', data=data)
    app.logger.info("received %s", data) 
    print('mqtt_message_received >>>>>>>>>', data)


@mqtt.on_log()
def handle_logging(client, userdata, level, buf):
    print("logging >>>>>>>> ", level, buf)
    pass


if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5000, use_reloader=False, debug=True)
