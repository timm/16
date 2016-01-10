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

def bounded(lst,lower,upper):
  def bounded1(x, lo, up):
    if   lo == up: return lo
    elif x  == up: return up
    else:
      return lo + ((x - lo) % (up - lo))
  return [bounded1(x,lo,up) for x,lo,up in 
          zip(lst, lower, upper)]

def truncated(lst,lower,upper):
  return [ min(max(x,lo),up) 
           for x,lo,up in zip(lst,lower,upper)]

def _restrain():
  lower  = [3,3,3,3]
  upper  = [7,7,7,7]
  data   = [2,3,7,8] 
  assert [6,3,7,4] == bounded( data,lower,upper)
  assert [3,3,7,7] == truncated(data,lower,upper)

def mutator(f): 
  warn = "too hard to satisfy %s" % f.__name__
  @wraps(f)
  def worker(old,
             lower      = None,
             upper      = None,
             ok       = None,
             evaluate = None, 
             retries  = the.MUTATE.retries):
    dec1 = f(old,lower, upper)
    dec2 = the.MUTATE.restrain(dec1,lower,upper)
    new  = o(objs=None,decs = dec2)
    if ok:
      assert retries > 0,warn
      if not ok(new):
        return worker(*l,
                      lower      = lower,
                      upper      = upper,
                      ok       = ok,
                      evaluate = evaluate,
                      retries  = retries-1)
    return evaluate(new) if evaluate else new
  return worker
  
@mutator
def mutate(old,lower,upper):
  p = the.MUTATE.sa.p
  return [x if r() <= p else lo + (up - lo)*r() 
          for x,lo,up 
          in  zip(old.decs,lower,upper)]

@mutator
def interpolate(all,_,__):
  return [x + r()*(y-z)
          for x,y 
          in  zip(any(all).decs,
                  any(all).decs)]
        
@mutator
def nudge((here,there),_,__):
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


def _mutators():
  reset()
  most = 10 
  all = [r() for _ in xrange(most)]
  for _ in range(10):
    
  got2 = Num([r() for _ in xrange(most)]).also().range

main(__name__,
      _restrain)

