Test Plan for ESP-IDF Docker Workflow on Raspberry Pi

The following tests will verify the functionality of the ESP-IDF Docker workflow on a Raspberry Pi, ensuring that it works correctly with minimal configuration.
Preparation

Before running the tests, ensure the following prerequisites are met:

    The Raspberry Pi is running a 64-bit OS.
    Docker is installed and operational:
        Verify by running:

        docker --version

    ESP-IDF project files are available in a directory for testing (e.g., /home/pi/esp-project).

Tests
1. Verify Docker Installation

    Purpose: Confirm Docker is installed and functioning on the Raspberry Pi.
    Steps:
        Run:

        docker run hello-world

        Observe the output.
    Expected Result:
        Docker successfully runs the hello-world container, and you see a message indicating Docker is installed and working.

2. Pull ESP-IDF Docker Image

    Purpose: Ensure the ESP-IDF Docker image can be pulled successfully.
    Steps:
        Run:

    docker pull espressif/idf

    Observe the output.

Expected Result:

    The ESP-IDF image is downloaded without errors.
    Confirm by listing Docker images:

        docker images

        You should see the espressif/idf image in the list.

3. Validate Docker ESP-IDF Environment

    Purpose: Verify the ESP-IDF Docker container starts and is functional.
    Steps:
        Create a test directory:

mkdir /home/pi/esp-test

Run the Docker container:

        docker run --rm -v /home/pi/esp-test:/project -w /project espressif/idf idf.py --version

        Observe the output.
    Expected Result:
        The Docker container executes the idf.py command and displays the ESP-IDF version.

4. Build a Sample ESP-IDF Project

    Purpose: Test the full build process for an ESP-IDF project using Docker.
    Steps:
        Clone an ESP-IDF example project:

git clone https://github.com/espressif/esp-idf-template.git /home/pi/esp-project

Run the build process in Docker:

        docker run --rm -v /home/pi/esp-project:/project -w /project espressif/idf idf.py build

        Observe the output.
    Expected Result:
        The project builds successfully without errors.
        Confirm the presence of the build directory in /home/pi/esp-project.

5. Flash an ESP32 Device

    Purpose: Test flashing a built project onto an ESP32 device using Docker.
    Steps:
        Connect the ESP32 to the Raspberry Pi via USB.
        Identify the serial port:

ls /dev/ttyUSB*

Flash the device:

        docker run --rm --device=/dev/ttyUSB0 -v /home/pi/esp-project:/project -w /project espressif/idf idf.py flash

        Observe the output.
    Expected Result:
        The firmware is successfully flashed to the ESP32.
        The output confirms a successful connection to the ESP32 device.

6. Monitor Serial Output

    Purpose: Ensure you can monitor the ESP32's serial output using the Docker container.
    Steps:
        Run:

        docker run --rm --device=/dev/ttyUSB0 -v /home/pi/esp-project:/project -w /project espressif/idf idf.py monitor

        Observe the output.
    Expected Result:
        The serial monitor starts, and you can see logs from the ESP32 device.

7. Validate Persistent Project Workflow

    Purpose: Verify that project files remain intact and usable after building and flashing.
    Steps:
        Confirm the presence of the build directory in /home/pi/esp-project.
        Run additional commands like idf.py menuconfig via Docker:

        docker run --rm -v /home/pi/esp-project:/project -w /project espressif/idf idf.py menuconfig

    Expected Result:
        The menuconfig utility runs successfully.
        Project files are unchanged and remain functional.

Troubleshooting

    If any step fails, check:
        Docker logs using:

journalctl -u docker

ESP32 connection with:

        dmesg | grep ttyUSB

        The Raspberry Pi's architecture (arm64) to ensure compatibility.

Summary

This test plan ensures a reliable setup and use of ESP-IDF within a Docker container on a Raspberry Pi. By following these tests, you can systematically verify that the Docker-based development environment is functional and ready for ESP32 development. Let me know if you need more assistance!
