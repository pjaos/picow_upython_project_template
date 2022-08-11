#!/bin/sh
# Requires rshell is installed (pip install rshell)
#
# Requires a single argument. This is the USB port number.
# E.G for /dev/ttyUSB0 you should pass an argument of 0.
#
# This script copies all the files to the picow flash and then runs the main.py
# program.
# First delete any files ending ~ in the local webroot folder as we don't want
# these on the picow.
rm webroot/*~
# Delete the /webroot folder where all the html, css and javascript files are kept
# to allow a web interface to be presented to the user.
rshell --timing -p /dev/ttyACM$1 --buffer-size 512 rm -rf /pyboard/webroot
# Remove all the python files from the picow flash
rshell --timing -p /dev/ttyACM$1 --buffer-size 512 rm -rf /pyboard/*.py
# Create the /webroot folder in the picow flash.
rshell --timing -p /dev/ttyACM$1 --buffer-size 512 mkdir webroot /pyboard/webroot
# Copy all the html, css and javascript files into the /webroot folder on the picow flash.
rshell --timing -p /dev/ttyACM$1 --buffer-size 512 cp webroot/* /pyboard/webroot
# Copy all the python src files top the picow flash.
# The picow will run the main.py file this when it powers up.
rshell --timing -p /dev/ttyACM$1 --buffer-size 512 cp *.py /pyboard
# Run the main.py file on the picow
rshell --timing -p /dev/ttyACM$1 --buffer-size 512 repl pyboard import main.py
