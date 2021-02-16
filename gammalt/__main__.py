from scipy.interpolate import BSpline
import matplotlib.pyplot as plt
import numpy
import scipy.fftpack 
import scipy.signal
from Calculator import Calculator 
from cgmparser.Parser import Parser as parser

def plot_interpolated_values(times, values, show_plot=False, savefig=False):
    spl = BSpline(times, values, k = 1)
    spl_list = []

    for index in range(times[-1]):
        spl_list.append(spl(index))

    fig = plt.figure()
    plt.plot(range(times[-1]), spl_list)
    fig.suptitle("Interpolated values")
    plt.xlabel("Time [min]")
    plt.ylabel("Blood glucose level [mmol/L]")
    plt.tight_layout()
    if savefig:
        plt.savefig("interpolated.png")
    if show_plot:
        plt.show()

"""
Plots differentiated list and returns
"""
def plot_differentiated_values(values, show_plot=False, title="Differentiated values", order=1, savefig=False):
    diff_list = get_differentiated(values)

    fig = plt.figure()
    plt.plot([value * 15 for value in range(len(diff_list))], diff_list, '-ok') # measures each 15 min...
    fig.suptitle(title)
    plt.xlabel("Time [min]")
    plt.ylabel(f"Blood glucose level [mmol/(Lmin^-{order})]")
    plt.tight_layout()
    if savefig:
        plt.savefig(f"{order}st-order.png")
    if show_plot:
        plt.show()
    return diff_list

def plot_fft(values, T = 1.0/800.0):
    N  = len(values)
    x = numpy.linspace(0.0, N*T, N)
    yf = scipy.fftpack.fft(values)
    xf = numpy.linspace(0.0, int(1.0/(2.0*T)), int(N/2))

    plt.plot(xf, 2.0/N * numpy.abs(yf[:N//2]))

if __name__ == "__main__":
    parser().parse_csv_data(filename="Karl JohannesJondell_glucose_7-12-2020.csv")
