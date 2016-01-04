from __future__ import print_function, division
import random,math, sys
sys.dont_write_bytecode = True

from boot import *

#### pretty print stuff 

def r3(x)    : return round(x,3)
def r3s(lst) : return map(r3,lst)
def r4(x)    : return round(x,4)
def r4s(lst) : return map(r4,lst)
def r5(x)    : return round(x,5)
def r5s(lst) : return map(r5,lst)

def say(x): 
  sys.stdout.write(str(x)); sys.stdout.flush()

#### one-liners  

r      = random.random
any    = random.choice
within = random.uniform
rseed   = random.seed
sqrt   = math.sqrt
exp    = math.exp
ee     = math.e
pi     = math.pi
div   = lambda x,y: x/(y+0.00001)

#### list stuff

def first(lst): return lst[0]
def second(lst): return lst[1]
def last(lst): return[-1]
  
#### misc stuff

def same(x): return x
def lt(x,y): return x < y
def gt(x,y): return x > y

