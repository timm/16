from __future__ import print_function, division
import  math,sys 
sys.dont_write_bytecode = True 

from boot import *

def identity(x): return x

log = math.log

def log2(x): return math.log(x,2)

def gt(x,y) : return x > y
def lt(x,y) : return x < y

def r3(x)   : return round(x,3)
def r3s(lst): return map(r3,lst)
def sayl(lst):
    def prep(x):
      if isinstance(x,float): x = "%5.3f" % x
      return(str(x))
    print(' '.join(map(prep,lst)))

class DefaultDict(dict):
    """Dictionary with a default value for unknown keys."""
    def __init__(i, default):
        i.default = default
    def __getitem__(i, key):
        if key in i: return i.get(key)
        return i.setdefault(key, i.default())
     