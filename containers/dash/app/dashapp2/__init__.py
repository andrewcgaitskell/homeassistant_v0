import dash
from dash import Dash, dcc, html, Input, Output, State, callback
import paho.mqtt.client as mqtt

global current_message
current_message = "NaN"


app = dash.Dash(
    __name__,
    requests_pathname_prefix='/dashapp2/'
)

# The callback for when the client receives a CONNACK response from the server.
def mqtt_on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe("myroom")

# The callback for when a PUBLISH message is received from the server.
def mqtt_on_message(client, userdata, msg):
    #print(msg.topic+" "+str(msg.payload))
    #global current_message
    current_message = msg.topic+" "+str(msg.payload)
    #html.Div(id='current_message', children=current_message)
    print("current_message received >>>>>>>>>" , current_message)

# app.layout = html.Div("Dash app 2")  

client = mqtt.Client(transport='websockets')
client.on_connect = mqtt_on_connect
client.on_message = mqtt_on_message
client.connect('mosquitto_container', 8080, 60)
#client.subscribe("myroom")

# Blocking call that processes network traffic, dispatches callbacks and
# handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a
# manual interface.
client.loop_start()

app.layout = html.Div([
    dcc.Interval(id='message_update', n_intervals=0, interval=1000*3),
    html.Div(dcc.Input(id='input-on-submit', type='text')),
    html.Button('Submit', id='submit-val', n_clicks=0),
    html.Div(id='container-button-basic',
             children='Enter a value and press submit'),
    html.Div(id='current_message',
             children='mqtt message here')
])


@callback(
    Output('container-button-basic', 'children'),
    Input('submit-val', 'n_clicks'),
    State('input-on-submit', 'value'),
    prevent_initial_call=True
)
def update_output(n_clicks, value):
    return 'The input value was "{}" and the button has been clicked {} times'.format(
        value,
        n_clicks)


@app.callback(
    Output('current_message', 'children'),
    Input('message_update', 'n_intervals')
)
def update_message(timer):
    global current_message
    print("current_message in callback >>>>>>>>>", current_message)
    return ("current_message: " + str(current_message))
