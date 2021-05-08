#!/usr/bin/python3
'''
*****
***** TODO: - samla ihop meddelanden och skicka ett mejl per dag? för att minimera mejlutskick
*****
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

sg = sendgrid.SendGridAPIClient(api_key=os.environ.get("SENDGRID_API_KEY", default="true"))
from_email = Email("info@radiodiabetes.eu")
to_email = To("kj@jondell.com")
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

        message = request.form['message'].strip() + "\n"

        if len(message)>0:
            with open(f"../../messages/{datetime.datetime.now().strftime('%Y%m%d-%H_%M_%S')}.txt", "w") as message_file:
                message_file.write(message)
                try:
                    content = Content("text/plain", message)
                    mail = Mail(from_email, to_email, subjekt, content)
                    response = sg.client.mail.send.post(request_body=mail.get())
                except:
                    print(sys.exc_info()[0])#do not crash if unable to send mail!
        return {'uploadSuccess' : True}
    except:
        print(sys.exc_info()[0])
        return {'uploadSuccess' : False}

if __name__ == '__main__':
    app.run(debug = True)
 
