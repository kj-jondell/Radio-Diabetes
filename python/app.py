#!/usr/bin/python3
'''
*****
***** TODO: - Köa datan?
*****
'''
from flask import Flask, render_template, request, redirect, url_for
from werkzeug.utils import secure_filename
from DataSender import DataSender 
import sendgrid
from sendgrid.helpers.mail import *

import datetime

from threading import Thread
from pythonosc import udp_client

import os, sys

app = Flask(__name__)

sg = sendgrid.SendGridAPIClient(api_key=app.config['SENDGRID_API_KEY'])
from_email = Email("info@radiodiabetes.eu")
to_email = Email("kj@jondell.com")
subjekt = "Nytt bidrag!"

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
            with open(f"../../messages/{datetime.datetime.now().strftime('%Y%m%d-%H_%M_%S')}.txt", "w") as message_file:
                message_file.write(message)
                content = Content("text/plain", message)
                mail = Mail(from_email, to_email, subjekt, content)
                response = sg.client.mail.send(post(request_body=mail.get()))
                print(response.status_code)
                print(response.body)
                print(response.headers)

        return {'uploadSuccess' : True}
    except ConnectionRefusedError as err:
        print(err)
    except:
        return {'uploadSuccess' : False}

if __name__ == '__main__':
    app.run(debug = True)
 
