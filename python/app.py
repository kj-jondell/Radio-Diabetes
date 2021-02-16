from flask import Flask, render_template, request, redirect, url_for
from werkzeug.utils import secure_filename
from DataSender import DataSender 

from threading import Thread
from pythonosc import udp_client

import os

app = Flask(__name__)
app.secret_key = os.urandom(42)
dataSender = DataSender()

@app.route('/')
def load_start_page():
    return render_template('index.html', title="Diabetes sonifiering")

@app.route('/uploader', methods=['POST'])
def upload_new_file():
    if request.method == 'POST':
        f = request.files['file']

        thread = Thread(target=dataSender.send_file, args=(f,))
        thread.daemon = True
        thread.start()

        return redirect(url_for('listen'))

@app.route('/listen')
def listen():
    return render_template('listen.html', title="Lyssna")

@app.route('/upload')
def upload_file():
    return render_template('upload.html', title="Uppladdning")

if __name__ == '__main__':
    app.run(debug = True)
