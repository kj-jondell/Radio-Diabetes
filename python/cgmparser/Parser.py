import xlrd 
# import soundfile as sf
from scipy.interpolate import BSpline
from scipy import signal
import numpy
import csv
from dateutil import parser

FILE_OUTPUT = "" # TODO vilket filnamn...
SAMPLE_RATE = 48000
AMT_OUTPUT = 10
BUFFER_SIZE = 2048
ROW_OFFSET = 5
SHEET_NO = 1

# Helper function TODO ha kvar eller inte??
#function taken from https://stackoverflow.com/questions/54032515/spectral-centroid-of-numpy-array
def spectral_centroid(x, samplerate = 48000):
    magnitudes = numpy.abs(numpy.fft.rfft(x))
    length = len(x)
    freqs = numpy.abs(numpy.fft.fftfreq(length, 1.0/samplerate)[:length//2+1])
    magnitudes = magnitudes[:length//2+1]
    return numpy.sum(magnitudes*freqs) / numpy.sum(magnitudes)

class Parser():

    """Docstring for Parser. """

    def __init__(self):
        pass

    """ Tolkar csv data """
    def parse_csv_data(self, stream):
        base_time = 0
        raw_times = []
        times = []

        values = []
        reader = csv.reader(stream, delimiter = ',')

        next(reader) # skip first row
        next(reader) # skip second row
        for row in reader:
            try:
                if(int(row[3])<=1):
                    values.append(float(row[4+int(row[3])].replace(',','.')))
                    raw_times.append(parser.parse(row[2]))
            except:
                continue
        base_time = min(raw_times)
        for time_value in raw_times:
            times.append(int((time_value-base_time).total_seconds()/60))
        return times, values
        
    """ Tolkar excel data """
    def parse_data(self, user_file):
        sheet = xlrd.open_workbook(file_contents=user_file).sheet_by_index(SHEET_NO)
        amt_data = sheet.nrows - ROW_OFFSET
        base_time = 0
        times = []
        values = []
        for row in range(amt_data):
            ### read and interpret data.
            date_string = sheet.cell_value(rowx = ROW_OFFSET + row, colx = 0)
            glucose_level = sheet.cell_value(rowx = ROW_OFFSET + row, colx = 1)

            date = parser.parse(date_string)
            values.append(glucose_level)

            if base_time == 0:
                base_time = date
            times.append((int)((date-base_time).total_seconds()/60))
        return times, values

    ### output extraction
    def extract_output(self, spl):
        centroids = list()
        for sample_index in range(0, AMT_OUTPUT): #TODO beräkna amt_output
            sample = []
            for x in range(BUFFER_SIZE*sample_index, BUFFER_SIZE*(sample_index+1)):
                sample.append(spl(x))
            sample = [(x-min(sample)) for x in sample]
            sample = [ 2*(x/(max(sample)-min(sample))-0.5) for x in sample] #normalize and center sound

            for ind, w_sample in enumerate(signal.hamming(BUFFER_SIZE)): #TODO annan windowing-funktion?
                sample[ind] = sample[ind]*w_sample

            centroids.append(spectral_centroid(sample, SAMPLE_RATE)) #prints spectral centroids (before formatting as wavetable but after windowing!)

            for ind, c_sample in enumerate(sample):
                if ind % 2 == 0:
                    sample[ind] = 2*sample[ind] - sample[ind+1]
                else:
                    sample[ind] = sample[ind] - sample[ind-1]

            #sf.write(f'{FILE_OUTPUT}{sample_index+1}', sample, SAMPLE_RATE) 
