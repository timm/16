from __future__ import print_function, division
import  sys 
sys.dont_write_bytecode = True 

from base import *

def identity(x): return x

class DefaultDict(dict):
    """Dictionary with a default value for unknown keys."""
    def __init__(i, default):
        i.default = default
    def __getitem__(i, key):
        if key in i: return i.get(key)
        return i.setdefault(key, i.default())