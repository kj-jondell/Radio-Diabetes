'''
*****
***** TODO: - Lägg till felhantering (dålig data...)
*****       - Köa datan?
*****
'''
from cgmparser.Parser import Parser
from pathlib import Path
from pythonosc import udp_client

import numpy
import io
import time
import xlrd

class DataSender:

    def __init__(self):
        self.client = udp_client.SimpleUDPClient("localhost", 7771) # PORT NR borde kanske inte hårdkodas?

    def __str__(self):
        return "A datasender..."

    def send_file(self, file):
        extension = Path(file.filename).suffix
        if extension == ".csv":
            times, values = Parser().parse_csv_data(stream=io.StringIO(file.stream.read().decode("UTF-8"), newline=None))
        elif extension in [".xls", ".xlsx"]:
            times, values = Parser().parse_data(user_file=file.read())
        else:
            return

        self.client.send_message('/newPackage', '') # implementera start-flagg
        for index, value in enumerate(values):
            self.client.send_message('/point', (value, times[index])) 
        self.client.send_message('/valueDone', '') 
