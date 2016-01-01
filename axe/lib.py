from __future__ import print_function, division
import  math,sys 
sys.dont_write_bytecode = True 

from boot import *

def identity(x): return x

log = math.log

def log2(x): return math.log(x,2)

def gt(x,y) : return x > y
def lt(x,y) : return x < y

class DefaultDict(dict):
    """Dictionary with a default value for unknown keys."""
    def __init__(i, default):
        i.default = default
    def __getitem__(i, key):
        if key in i: return i.get(key)
        return i.setdefault(key, i.default())
     