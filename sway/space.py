from __future__ import print_function, division
import  sys
sys.dont_write_bytecode = True 

from lib import *

@setting
def SPACE(): return o(
  norm=True
)

# need a way to init from a list

class Space:
  def __init__(i,one=None,value=same,inits=[]):
    i.value = value
    i.cache = {}
    i.lo, i.hi = None, None
    i.updates(inits)
  def ready(i,one):
    if not i.lo:
      i.lo    = [ 10**32 for _ in i.value(one)]
      i.hi    = [-10**32 for _ in i.value(one)]
  def updates(i,lst=[]):
    map(i.__add__,lst)
  def __add__(i,one):
    i.ready(one)
    for n,(lo,hi,new) in enumerate(zip(i.lo, i.hi,
                                       i.value(one))):
      if new > hi:
        i.hi[n] = new
      if new < lo:
        i.lo[n] = new
  def dist(i,xs,ys):
    a, b = id(xs), id(ys)
    if a > b:
      return i.dist(ys,xs)
    k = (a,b)
    if k in i.cache:
      return i.cache[k]
    else:
      i.cache[k] = d = i.dist1(xs,ys)
      return d
  def dist1(i,xs,ys,d=0,n=0):
    one = i.value(xs)
    two = i.value(ys)
    for n,(x,y) in enumerate(zip(one,two)):
      x  = i.norm(x,n) 
      y  = i.norm(y,n) 
      d += (x - y)**2
      n += 1
    return sqrt(d) / sqrt(n)
  def norm(i,x,n):
    if x < i.lo[n]: i.lo[n] = x
    if x > i.hi[n]: i.hi[n] = x
    if the.SPACE.norm:
      lo = i.lo[n]
      hi = i.hi[n]
      return div( (x- lo) , (hi - lo) )
    else:
      return x
  def furthest(i,one,all,better=gt,most=0):
    d, out = most, one
    for two in all:
      if id(two) != id(one):
        tmp = i.dist(one,two)
        if better(tmp,d):
          d,out = tmp,two
    return out,d
  def closest(i,one,all):
    return i.furthest(one,all,better=lt,most=10**32)


    