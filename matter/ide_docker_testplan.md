# Introduction

In the past I tried to do the following using online instructions and it failed.

Using ChatGPT to generate the process and knowing some of the pitfalls I managed to get this to work.

__RUN ALL OF THIS AS ROOT__

# Test Plan for ESP-IDF Docker Workflow on Raspberry Pi

The following tests will verify the functionality of the ESP-IDF Docker workflow on a Raspberry Pi, ensuring that it works correctly with minimal configuration.
Preparation

# prerequisites

Before running the tests, ensure the following prerequisites are met:

    The Raspberry Pi is running a 64-bit OS.
    Docker is installed and operational:
        Verify by running:

        docker --version

    ESP-IDF project files are available in a directory for testing (e.g., /home/pi/esp-project).

# Tests
## 1. Verify Docker Installation

    Purpose: Confirm Docker is installed and functioning on the Raspberry Pi.
    Steps:
        Run:

        docker run hello-world

        Observe the output.
        
    Expected Result:
    
        Docker successfully runs the hello-world container, and you see a message indicating Docker is installed and working.

## 2. Pull ESP-IDF Docker Image

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

## 3. Validate Docker ESP-IDF Environment

    Purpose: Verify the ESP-IDF Docker container starts and is functional.
    Steps:
        Create a test directory:

    mkdir /home/pi5ha/esp_test

    Run the Docker container:

        docker run --rm -v /home/pi5ha/esp_test:/project -w /project espressif/idf idf.py --version

        Observe the output.
        
    Expected Result:
    
        The Docker container executes the idf.py command and displays the ESP-IDF version.

## 4. Create then Build a ESP-IDF Project

    Run the create and build process in Docker:

    ## create

        docker run --rm -v /home/pi5ha:/home/pi5ha -w /home/pi5ha espressif/idf idf.py create-project my_project

        docker run --rm -v /home/pi5ha:/home/pi5ha -w /home/pi5ha espressif/idf idf.py create-project thread_project

    ## build

        docker run --rm -v /home/pi5ha/my_project:/project -w /project espressif/idf idf.py build

        docker run --rm -v /home/pi5ha/thread_project:/project -w /project espressif/idf idf.py build
        

        Observe the output.
        
    Expected Result:
    
        The project builds successfully without errors.
        
        Confirm the presence of the build directory in /home/pi/esp-project.

## 5. Flash an ESP32 Device

    Purpose: Test flashing a built project onto an ESP32 device using Docker.
    
    Steps:
    
        Connect the ESP32 to the Raspberry Pi via USB.
        
        Identify the serial port:

            ls /dev/ttyUSB*

    Flash the device:

        docker run --rm --device=/dev/ttyUSB0 -v /home/pi5ha/my_project:/project -w /project espressif/idf idf.py flash

        Observe the output.
        
        Expected Result:
        
            The firmware is successfully flashed to the ESP32.
        
            The output confirms a successful connection to the ESP32 device.

## 6. Monitor Serial Output

    Purpose: Ensure you can monitor the ESP32's serial output using the Docker container.
    
    Steps:
        Run:

        docker run --rm -it --device=/dev/ttyUSB0 -v /home/pi5ha/my_project:/project -w /project espressif/idf idf.py monitor

        Exit Key Combination

        Press Ctrl+] to exit the monitor gracefully.


        Observe the output.
        
        Expected Result:
        
            The serial monitor starts, and you can see logs from the ESP32 device.

## 8. Validate Persistent Project Workflow

    Purpose: Verify that project files remain intact and usable after building and flashing.
    
    Steps:
    
        Confirm the presence of the build directory in /home/pi5ha/my_project.
        
        Run additional commands like idf.py menuconfig via Docker:

        docker run --rm -it --device=/dev/ttyUSB0 -v /home/pi5ha/my_project:/project -w /project -e TERM=xterm-256color espressif/idf idf.py menuconfig

    Expected Result:
    
        The menuconfig utility runs successfully.
        
        Project files are unchanged and remain functional.

# Troubleshooting

    If any step fails, check:
        Docker logs using:

        journalctl -u docker

    ESP32 connection with:
    
            dmesg | grep ttyUSB
    
            The Raspberry Pi's architecture (arm64) to ensure compatibility.

# Summary

This test plan ensures a reliable setup and use of ESP-IDF within a Docker container on a Raspberry Pi. By following these tests, you can systematically verify that the Docker-based development environment is functional and ready for ESP32 development. Let me know if you need more assistance!
