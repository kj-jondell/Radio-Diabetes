from cgmparser.Parser import Parser as parser
from pythonosc import udp_client
from scipy.interpolate import BSpline
import argparse
import numpy

input_file = open("sample_data/ny1.xls", "rb").read()
times, values = parser().parse_data(input_file)
spl = BSpline(times, values, 1)

parser = argparse.ArgumentParser()
parser.add_argument("--ip", default="127.0.0.1")
parser.add_argument("--port", default=57120)

args = parser.parse_args()
client = udp_client.SimpleUDPClient(args.ip, args.port)

client.send_message("/newPackage", "differentiated")

def send_osc_message(value, time_value=None):
    if time_value != None:
        #print((value,time_value))
        client.send_message("/point", (value, time_value))
    else:
        client.send_message("/point", value)
    
for index, item in enumerate(values):
    send_osc_message(item, times[index])
    #print(item, times[index])

#for time in range(0, max(times)): # ett dygn...
    #print(spl(time))
    #send_osc_message(float(spl(time)))

# for time_value, value in sorted_list:
#     send_osc_message(time_value, value)
# 
# # skicka medelvärde (mean, mode, median), max o min, 
# client.send_message("/meta", [numpy.mean(values)])
# 
#client.send_message("/valueDoneDebug", "")
client.send_message("/valueDone", "")
