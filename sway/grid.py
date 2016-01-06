# sway
from __future__ import print_function, division
import  sys
sys.dont_write_bytecode = True 

from space import *

@setting
def GRID(): return o(
 bins=16, # each grid has bins**2 cells
 tooMuch= 1.000001 # regrowth grids when new "c" more than "bigger"
)

class Grid(Some)
  #XXX 
  def __init__(i,inits=[],space=None):
    i.one, i.two = None, None
    i.space = space or Space()
    i.worker = None
    map(i.__add__,inits)
  def __add__(i,x,out=(0,0)):
    if not i.one: 
      i.one = x  
    elif not i.two:
      i.two = x
      i.worker = Grid1(i.one,i.two,i.space) 
    else i.worker:
      out = i.worker + one
    return out
    
class Grid1:
  def __init__(i,east,west, space):
    i.reset()
    i.space = Space()
    map(i.__add__, inits)
  def reset(i):
    i.east, i.west = None,None
    i.c      = None
    i.values = [] 
    i._pos   = {}
    i.cells   = [[[] for _ in range(the.GRID.bins)]
                     for _ in range(the.GRID.bins)]
  def distances(i,one):
    i.space + one
    if i.c == None:
      i.c = i.space.dist(i.east,i.west) 
    a = i.space.dist(i.east,one)
    b = i.space.dist(i.west,one)
    return a, b, i.c
  def grow(i,east,west):
    say("*",len(i.values))
    b4 =  i.values[:]
    i.reset() 
    map(i.__add__,b4)
  def __add__(i,one):    
    i.values += [one]
    if len(i.values) < 3:
      return 0,0
    elif len(i.values) == 3:
      i.east = i.values[0]
      i.west = i.values[1]
      i.add(i.east)
      i.add(i.west)
      return i.add( one)
    else:
      return i.add(one)
  def add(i,one):
    a,b,c = i.distances(one)
    if c > 0:
      if  a > c*the.GRID.tooMuch : 
        i.grow(i.east,one)
        return i + one
      if b > c*the.GRID.tooMuch: 
        i.grow(one,i.west)
        return i + one
    x = div( a**2 + c**2 - b**2  , 2*c)
    x = a if x**2 > a**2 else x
    y = sqrt(a**2 - x**2)
    binx, biny = i.bin(x), i.bin(y)
    i.cells[ binx ][ biny ] += one
    i._pos[id(one)] = o(x=x,y=y,binx=binx,
                        biny=biny,a=a,b=b)
    return x,y
  def bin(i,x):
    x = int(x/((i.c+0.0001)/the.GRID.bins))
    return max(0,min(the.GRID.bins - 1, x))
  def pos(i,x) :
    return i._pos[id(x)]
    
def _grid(items=100,arity=5):
  def show(cell):
    p = len(cell)
    say(p," ")
    q = int(100 * p/len(g.values))
    return q if q else " "
  reset()
  g=Grid()
  #for _ in xrange(items):
   # one = [r3(r()/10) for _ in xrange(arity)]
    #g + one
  for _ in xrange(items):
    one = [r3(r()*10) for _ in xrange(arity)]
    g + one
  print("") 
  print(len(g.values))
  m= map(lambda cells:  
            map(lambda cell: show(cell), cells),
         g.cells)
  printm(m)
  print(len(g.values))
    
main(__name__,_grid)