# sway
from __future__ import print_function, division
import  sys
sys.dont_write_bytecode = True 

from space import *

@setting
def GRID(): return o(
 bins=16, # each grid has bins**2 cells
 tooMuch= 1.025, # regrowth grids when new "c" more than "bigger"
)

class Grid:
  def __init__(i,inits=[], space=None):
    i.reset()
    i.space = space or Space()
    i.east, i.west, i.c = None,None,None
    map(i.__add__, inits)
  def reset(i):
    i.values = [] 
    i._pos   = {}
    i.grid   = [[[] for _ in range(the.GRID.bins)]
                    for _ in range(the.GRID.bins)]
  def distances(one):
    i.space.update(one)
    if i.c == None:
      i.space.dist(i.east,i.west) 
    a = i.space.dist(i.east,one),
    b = i.space.dist(i.west,one)
    return a,b,c
  def grow(i,east,west):
    b4,i.east, i.west = i.values[:],east,west
    i.reset()
    i.c = i.space.dist(i.east,i.west)
    map(i.__add__,[i.east,i.west]+b4)
  def __add__(i,one):
    if not i.east: i.east = one; return 0,0
    if not i.west: i.west = one; return 0,0
    a,b,c = i.distances(one)
    if  a*the.GRID.tooMuch > c:
      i.grow(i.east,one)
      return i + one
    if b*the.GRID.tooMuch > c: 
      i.grow(one,i.west)
      return i + one
    i.values += [one]
    x = div( a**2 + c**2 - b**2  , 2*c)
    x = a if x**2 > a**2 else x
    y = sqrt(a**2 - x**2)
    binx, biny = i.bin(x), i.bin(y)
    i.grid[ binx ][ biny ] += one
    i._pos[id(one)] = o(x=x,y=y,binx=binx,
                        biny=biny,a=a,b=b)
      return x,y
  def bin(i,x):
    x = int(x/((i.c+0.0001)/the.GRID.bins))
    return max(0,min(the.GRID.bins - 1, x))
  def pos(i,x) :
    return i._pos[id(x)]