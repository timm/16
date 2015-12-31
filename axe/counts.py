from __future__ import print_function, division
import  sys 
sys.dont_write_bytecode = True

from table import *

class count:
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

class num(count):
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

class sym(count):
  def init(i):  i.all = {}
  def add(i,z):
    i.all[z] = i.all.get(z,0) + 1 
  def sub(i,z):
    i.all[z] -= 1
  def entropy(i,p=0):
    for k,v in i.all.items():
      p1 = v/i.n
      if p1 > 0:
        p += p1*log(p1,2)
    return abs(p)

def _count():
  n = num()
  lst = xrange(256)
  ups=[]
  for i,x in enumerate(lst):
    n += x
    ups += [n.sd()]
    if i==4:
      assert abs(n.sd() - 1.5811) < 0.001
  downs=[]
  for x in reversed(lst):
     downs += [n.sd()]
     n -= x
  assert ups ==  downs[::-1]
  
main(__name__) and ok(_count)