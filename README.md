# Pi Environment Monitoring

## General:
- Runs now in Docker Container
- Makefile for clean / build / start / up

## Requirements:
### Hardware: 
- BME280 Temperature/Pressure/Humidity sensor (We used this one: https://www.adafruit.com/product/2652)
- Raspberry Pi (or similar)
### Environment:
- Python3
- Python3-pip
- docker / docker-compose
- telegraf

## Quick-Start:
### Pre-requirities:
- open terminal
- install docker with following command "curl -fsSL https://get.docker.com -o get-docker.sh"
- run it with "sudo sh get-docker.sh"
- install docker-compose with "sudo apt-get install docker-compose"

### Container setup
- Place whole iot_project folder in /home/pi
- change into iot_project with "cd iot_project"
- Edit the following environment/user specific values:
    - docker-compose.yml: INFLUXDB_ADMIN_PASSWORD and INFLUXDB_USER_PASSWORD
    - telegraf.conf: site, hostname, urls for outputs.influxdb, command for inputs.exec
- make dump_bme280.py run-able (chmod 755 dump_bme280.py)
- Build and run the container with "sudo make"

### Sensor & Environment setup
- install python3-pip (sudo apt-get install python3-pip)
- install missing python packages, type "sudo su" to change to root user and make the following commands
    - pip3 install smbus2
    - pip3 install rpi-bme280
- type exit to switch back to pi user
- add repository with command "curl -s https://repos.influxdata.com/influxdb.key | sudo apt-key add -"
- copy influxdb.list to /etc/apt/sources.list.d (sudo cp influxdb.list /etc/apt/sources.list.d/)
- run sudo apt-get update && sudo apt-get upgrade
- run sudo apt-get install telegraf
- copy telegraf.conf to /etc/telegraf/telegraf.conf (sudo cp telegraf.conf /etc/telegraf/telegraf.conf)
- enable i2c communication to read sensor values with "sudo raspi-config" go to "Interface Options" and enable I2C
- add telegraf user to i2c-users with "sudo adduser telegraf i2c"
- reboot your pi (sudo reboot)
- test config with telegraf --test (output should be your sensor values)


- open browser and access http://YOUR_PI_IP:3000 to access the grafana dashboard
- open browser and access http://YOUR_PI_PI:8888 to access chronograf (explorer for influxdb database)

