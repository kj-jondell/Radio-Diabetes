import xlrd 
import csv
from dateutil import parser

ROW_OFFSET = 5
SHEET_NO = 1

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
