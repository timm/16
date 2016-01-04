from __future__ import print_function, division
import  sys
sys.dont_write_bytecode = True 

from space import *

class Log:
  "Holds individuals, knows their geometry."
  def __init__(i,inits, value=same,
               big=0.025,bins=16,space=None):
    i.big, one, i.value,i.values = big,inits[0],value,inits[:]
    i.bins = bins
    i._pos  = {}
    i.space = space or Space(one,value=value)
    i.cells   = [[[] for _ in range(bins)]
                for _ in range(bins)]
    map(i.space.update,inits)
    i.east,_ = i.space.furthest(one,    i.values)
    i.west,_ = i.space.furthest(i.east, i.values)
    i.grow(i.east,i.west)
  def grow(i,east,west):
    print("_",end="")
    b4,i.east, i.west = i.values[:],east,west
    i.c = i.space.dist(i.east,i.west)
    i._pos      = {}
    i.cells     = [[[] for _ in range(i.bins)]
                   for _ in range(i.bins)]
    map(i.__add__,[i.east,i.west]+b4)
  def about(i,one):
    return i._pos[id(one)]
  def __add__(i,one):
    a = i.space.dist(i.east,one)
    b = i.space.dist(i.west,one)
    if  a - i.c > i.big:
      i.grow(i.east,one)
      return i + one
    elif b - i.c > i.big:
      i.grow(one,i.west)
      return i + one
    else:
      i.space.update(one)
      x = (a**2 + i.c**2 - b**2) / (2*i.c + 0.0001)
      if x**2 > a**2:
        x = a
      y = sqrt(a**2 - x**2)
      binx, biny = i.bin(x), i.bin(y)
      items = i.cells[ binx ][ biny ]
      before = items[0] if items else None
      items += [one]
      i.values += [one]
      i._pos[id(one)] = o(x=x,y=y,binx=binx,
                          biny=biny,a=a,b=b)
      return before,x,y
  def bin(i,x):
    x = int(x/((i.c+0.0001)/i.bins))
    return max(0,min(i.bins - 1, x))
  def pos(i,x) :
    return i._pos[id(x)]
  def clone(i,inits=[]):
    return Log(inits, value=i.value,
                      big=i.big,bins=i.bins, space=i.space)
  def best(i,want,most=0.33,cmp=lt):
    if east is want:
      return i.clone([x for x in i.values if
                      i.pos(x).a/i.pos(x).b < most])
    else:
      return i.clone([x for x in i.values if
                      i.pos(x).a/i.pos(x).b >  (1 - most)])
  def bounds(i):
    xs= sorted([one.x for one in i.values])
    ys= sorted([one.y for one in i.values])
    return (xs[0]*0.95,xs[-1]*1.05),(ys[0]*0.95,ys[-1]*1.05)