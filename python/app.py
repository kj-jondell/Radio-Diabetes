#!/usr/bin/python3
'''
*****
***** TODO: - Köa datan?
*****
'''
from flask import Flask, render_template, request, redirect, url_for
from werkzeug.utils import secure_filename
from DataSender import DataSender 

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

        return {'uploadSuccess' : True}
    except:

        return {'uploadSuccess' : False}

if __name__ == '__main__':
    app.run(debug = True)
 
