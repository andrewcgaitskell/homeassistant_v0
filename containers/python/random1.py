import time
import random
import paho.mqtt.client as mqtt


def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe("$SYS/#")

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))

client = mqtt.Client(transport='websockets')
client.on_connect = on_connect
client.on_message = on_message

client.connect("0.0.0.0", 8080, 60)


# Main function
if __name__ == "__main__":
    print("Publishing...")
    
    while True:
        rr = random.random()
        client.publish("myroom", rr)
        print(rr)
        time.sleep(2)
