from quart import Quart, jsonify, request
from matter_server.server import MatterServer  # Adjust based on actual Matter API

app = Quart(__name__)

# Initialize the Matter server
matter_server = MatterServer()

@app.before_serving
async def start_matter():
    """Start the Matter server before the Quart app starts."""
    await matter_server.start()

@app.after_serving
async def stop_matter():
    """Stop the Matter server when the Quart app shuts down."""
    await matter_server.stop()

@app.route('/devices', methods=['GET'])
async def get_devices():
    """Fetch connected Matter devices."""
    devices = await matter_server.get_devices()
    return jsonify(devices)

@app.route('/control/<device_id>', methods=['POST'])
async def control_device(device_id):
    """Send a control command to a Matter device."""
    data = await request.json
    command = data.get("command")
    response = await matter_server.send_command(device_id, command)
    return jsonify(response)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5555)
