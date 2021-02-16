# from websockets import ...
from cgmparser.Parser import Parser 
from flask import Flask, render_template, request 

class OSCSender:

    """ OSCSender is the main class handling incoming data and sending it to the openFrameworks/SuperCollider programs over OSC. Connects to a WebServer, which provides the data. """

    def __init__(self, filename = None):
        pass

class WebServer:

    def __init__(self):
        app = Flask(__name__, template_folder = 'templates')

        @app.route("/upload")
        def upload_file():
            return render_template('upload.html') #frontend stuff

        @app.route("/uploader", methods = ['GET', 'POST'])
        def upload_a_file():
            if request.method == 'POST':
                f = request.files['file']
                f.save(f.filename)
                return 'file uploaded successfully'

        app.run(host='0.0.0.0', debug=True)

WebServer()

#OSCSender()

