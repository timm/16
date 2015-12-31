from __future__ import print_function, division
import  math,sys 
sys.dont_write_bytecode = True 

from base import *

def identity(x): return x

log = math.log

def gt(x,y) : return x > y
def lt(x,y) : return x < y

class DefaultDict(dict):
    """Dictionary with a default value for unknown keys."""
    def __init__(i, default):
        i.default = default
    def __getitem__(i, key):
        if key in i: return i.get(key)
        return i.setdefault(key, i.default())
        
def main(x):
  print(__name__)
  return x == '__main__'
    