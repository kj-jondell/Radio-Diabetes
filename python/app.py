#!/usr/bin/python3
'''
*****
***** TODO: - Köa datan?
*****
'''
from flask import Flask, render_template, request, redirect, url_for
from werkzeug.utils import secure_filename
from DataSender import DataSender 
import datetime

from threading import Thread
from pythonosc import udp_client

import os

app = Flask(__name__)

app.secret_key = os.urandom(42)
app.debug = True
dataSender = DataSender()

print("SETUP Complete...")

@app.route('/api/uppladdning', methods=['POST'])
def upload():
    try:
        f = request.files['file']

        dataSender.send_file(f)

        message = request.form['message'].strip()

        if len(message)>0:
            with open(f"{os.getcwd()}/messages/{datetime.datetime.now().strftime('%Y%m%d-%H_%M_%S')}.txt", "w") as message_file:
                message_file.write("HELLO")
                print("hello")
#                message_file.write(message)

        return {'uploadSuccess' : True}
    except:

        return {'uploadSuccess' : False}

if __name__ == '__main__':
    app.run(debug = True)
 
