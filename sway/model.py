# Sway
from __future__ import print_function, division
import  sys
sys.dont_write_bytecode = True 

from lib import *

@setting
def MODEL(): return o(
  retries=100,
  bigEnough=1.01
)

class Objective:
  def __init__(i,txt,maker=None,better=lt):
      i.better = better
      i.txt,i.maker = txt,maker
  def __call__(i,x):
      return i.maker(x)

def More(*l,**d): return Objective(*l,better=gt,**d)
def Less(*l,**d): return Objective(*l,better=lt,**d)
    
class Decision:
    def __init__(i,str,lo=None,hi=None):
        i.str,i.lo,i.hi = str,lo,hi
    def __call__(i):
        return i.lo + r()*(i.hi - i.lo)

An = A = Decision

def decs(x): return x.decs
def objs(x): return x.objs

class Model:
    def __init__(i):
        i.about() 
    def eden(i):
      return  o(objs=None,decs=[f() for f in i.decs])
    def ok(i,x): 
      return True
    def decide(i,retries=None):
      if retries == None: 
        retries = the.MODEL.retries
      while True:
        x = i.eden() 
        if i.ok(x): return x 
        retries -= 1
        assert retries>0,'cannot satisfy constraints while creating'
    def eval(i,x):
      if not x.objs:
        x.objs = [f(x) for f in i.objs] 
      return x
    def select(i,x,y,how="bdom",space=None):
      return i.bdom(x,y,space) if how == "bdom" else i.cdom(x,y,space)
    def bdom(i,x,y,_=None):
        betters = False
        for u,v,meta in zip(x.objs,y.objs,i.objs):
            if meta.better(u,v):
                betters =True
            elif u != v:
                return False
        return betters
    def cdom(i,x, y,space):
      def w(better):
        return -1 if better == lt else 1
      def expLoss(better,x,y,n):
        return -1*ee**( w(better)*(x - y) / n )
      def loss(x, y):
        x,y    = x.objs, y.objs
        x      = [space.norm(x1,m) for m,x1 in enumerate(x)]
        y      = [space.norm(y1,m) for m,y1 in enumerate(y)]
        n      = min(len(x), len(y)) #lengths should be equal
        losses = [ expLoss(meta.better,xi,yi,n)
                   for xi, yi,meta
                   in zip(x,y,i.objs) ]
        return sum(losses) / n
      return loss(x,y) * bigEnough < loss(y,x) 

def tournament(model,frontier,space,how='bdom'):
  for x in frontier:
    x.alive = True
  for x in frontier:
    for y in frontier:
      if y.alive:
        if model.select(x,y,how=how,space=space):
          y.alive = False
  return [f for f in frontier if f.alive]

if __name__ == '__main__':
   print('# Note:\n# To test model.py, load models.py')
