# sway
from __future__ import print_function, division
import  sys
sys.dont_write_bytecode = True 

from lib import *
from functools import wraps

@setting
def MUTATE(): return o(
  sa       = o(p    = 0.33),
  nudge    = o(push = 2),
  de       = o(cr = 0.7, f=0.3),
  retries  = 100,
  restrain = lambda x,sp: bounded(x,sp)
)

def bounded(lst,los,his):
  def bounded1(x, y,z)
    return y if y==z else y + ((x - y) % (z - y))
  return [bounded1(x,lo,hi) for n,x in 
          enumerate(lst, los, his)]

def truncated(x,lo,hi):
  return [min(x,max(x,lo),hi) for n,x in 
          enumerate(lst,los,his)]

def _restrain():
  los  = [3,3,3,3]
  his  = [7,7,7,7]
  data = [2,3,7,8]
  assert [6,3,7,4] == bounded( data,los,his)
  assert [3,3,7,7] == truncated(data,los,his)

def mutator(f): 
  warn = "too hard to satisfy %s" % f.__name__
  @wraps(f)
  def worker(*l,
             los      = None,
             his      = None,
             ok       = None,
             evaluate = None, 
             retries  = the.MUTATE.RETRIES):
    dec1 = f(*l,los, his)
    dec2 = the.MUTATE.restrain(dec1,los,his)
    new  = o(objs=None,decs = dec2)
    if ok:
      assert retries > 0,warn
      if not ok(new):
        return worker(*l,
                      los      = los,
                      his      = his,
                      ok       = ok,
                      evaluate = evaluate,
                      retries  = retries-1)
    return evaluate(new) if evaluate else new
  return worker
  
@mutator
def mutate(old,los,his):
  p = the.MUTATE.sa.p
  return [x if r() <= p else lo + (hi - lo)*r() 
          for x,lo,hi 
          in  zip(old.decs,los,his)]

@mutator
def interpolate(all,_,__):
  return [x + r()*(y-z)
          for x,y 
          in  zip(any(all).decs,
                  any(all).decs)]
        
@mutator
def nudge(here,there,_,__):
   return [ here1 + r()*push*(there1-here1)
            for here1,there1
            in  zip(here.decs, 
                    there.decs) ]
            
@mutator
def smear(all,_,__):
  aa, bb, cc = any(all), any(all), any(all)
  tmp=  [a + f*(b - c) if r()< cr else a
         for a,b,c
         in  zip(aa.decs,  
                 bb.decs,  
                 cc.decs)]
  n = random.randint(0,len(aa))
  tmp[n] = aa[n]
  return tmp

main(__name__) and ok(_restrain)

