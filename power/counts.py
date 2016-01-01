from __future__ import print_function, division
import  sys 
sys.dont_write_bytecode = True

from table import *

class Count:
  def __init__(i,inits=[]):
    i.init()
    i.n = 0 
    map(i.__iadd__,inits)  
  def __isub__(i,x): i.sub(x); return i
  def __iadd__(i,x):
    if x != the.CSV.missing:
      i.n += 1 
      i.add(x)
    return i

class Num(Count):
  def init(i): i.mu = i.m2 = 0  
  def sd(i):
    return 0 if i.n < 2 else (i.m2/(i.n - 1))**0.5
  def add(i,z): 
    delta = z - i.mu;
    i.mu += delta/i.n
    i.m2 += delta*(z - i.mu)
    return i
  def sub(i,x): 
    if i.n < 2: return i.init()
    i.n  -= 1
    delta = x - i.mu
    i.mu -= delta/(1.0*i.n)
    i.m2 -= delta*(x - i.mu)

class Sym(Count):
  def init(i):  i.all = {}
  def add(i,z):
    i.all[z] = i.all.get(z,0) + 1 
  def sub(i,z):
    tmp = i.all[z] = i.all[z] - 1
    if tmp < 1: del i.all[z]
  def k(i): 
    return len(i.all.keys())
  def ent(i,p=0):
    for k,v in i.all.items():
      p1 = v/i.n
      if p1 > 0:
        p += p1*log(p1,2)
    return abs(p)
      
def _count():
  num = Num()
  lst = xrange(256)
  ups=[]
  for i,x in enumerate(lst):
    num += x
    ups += [num.sd()]
    if num.n == 5:
      assert abs(num.sd() - 1.5811) < 0.001
  downs=[]
  for x in reversed(lst):
     downs += [num.sd()]
     num -= x
     if num.n==5:
      assert abs(num.sd() - 1.5811) < 0.001
  assert ups ==  downs[::-1]
  
__name__ == '__main__' and ok(_count)