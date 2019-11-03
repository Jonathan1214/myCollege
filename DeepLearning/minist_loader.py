import pickle
import gzip

import numpy as np

def load_data():
    f = gzip.open('./data/', 'rb')