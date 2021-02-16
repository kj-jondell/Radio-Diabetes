from cgmparser.Parser import Parser
from pathlib import Path
from pythonosc import udp_client

import numpy
import io
import time
import xlrd

class DataSender:

    def __init__(self):
        self.client = udp_client.SimpleUDPClient("localhost", 7771)

    def send_file(self, file):
        extension = Path(file.filename).suffix
        if extension == ".csv":
            times, values = Parser().parse_csv_data(stream=io.StringIO(file.stream.read().decode("UTF-8"), newline=None))
        elif extension in [".xls", ".xlsx"]:
            times, values = Parser().parse_data(user_file=file.read())
        else:
            return

        self.client.send_message('/newPackage', '') # implementera start-flagg
        for value in values:
            self.client.send_message('/value', value) # test som skickar OSC meddelande till Supercollider (Sched.scd)
        self.client.send_message('/meta', ["mean", numpy.mean(values)])
        self.client.send_message('/valueDone', '') # test som skickar OSC meddelande till Supercollider (Sched.scd)

# print(numpy.mean(values), numpy.median(values), numpy.max(values), numpy.min(values))
# # skicka medelvärde (mean, mode, median), max o min, 
# client.send_message("/meta", [numpy.mean(values)])
