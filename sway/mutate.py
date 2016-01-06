# sway
from __future__ import print_function, division
import  sys
sys.dont_write_bytecode = True 

from lib import *

@setting
def MUTATE(): return o(
  p=0.33,
  retries=100
)

def mutator(f):
  def worker(old): 
    retries=the.MUTATE.RETRIES
    tmp= o(objs=None,
         decs = f(old))
  if ok:
    assert retries > 0,'too hard to satisfy constraints in mutation'
    if not ok(tmp):
      return worler(one,
                    log=log,p=p, value=value,
                    evaluate=evaluate, ok=ok,
                    retries=retries - 1)
  return evaluate(tmp) if evaluate else tmp
  
def mutate(one,log=None,p=0.33, value=same,evaluate=None,ok=None,retries=100):
  p = the.MUTATE.p
  retries=the.MUTATE.RETRIES
  tmp= o(objs=None,
         decs = [mutate1(old,p,log.space.lo[n],log.space.hi[n])
                   for n,old
                   in enumerate(value(one))])
  if ok:
    assert retries > 0,'too hard to satisfy constraints in mutation'
    if not ok(tmp):
      return mutate(one,
                    log=log,p=p, value=value,
                    evaluate=evaluate, ok=ok,
                    retries=retries - 1)
  return evaluate(tmp) if evaluate else tmp

def mutate1(old,p,lo,hi):
  x = (hi - lo)
  y = old if p >= r() else lo + x*r()
  return bound(y,lo,hi)

def bound(x, lo, hi):
  return lo if lo==hi else lo + ((x - lo) % (hi - lo))
  

def interpolate(all,ok=None,retries=20,evaluate=None):
   one=any(all)
   two=any(all)
   tmp = o(objs = None,
             decs = [x + r()*(y-x)
                     for x,y in zip(one.decs,two.decs)])
   if ok:
     assert retries > 0, 'too hard to satisfy constraints'
     if not ok(tmp):
       return interpolate(all,ok=ok,retries=retries-1,evaluate=evaluate)
   return evaluate(tmp) if evaluate else tmp

def nudge(here,there,log=None,ok=None,retries=20,evaluate=None,push=4):
   "nudge here towards there"
   tmp = o(objs = None,
             decs = [bound(here1 + r()*push*(there1-here1),log.space.lo[n],log.space.hi[n])
                     for n,(here1,there1) in enumerate(zip(here.decs,there.decs))])
   if ok:
     assert retries > 0, 'too hard to satisfy constraints'
     if not ok(tmp):
       return nudge(here,there,log=None,push=push,ok=ok,retries=retries-1,evaluate=evaluate)
   return evaluate(tmp) if evaluate else tmp
 
def smear(all,log=None,f=0.25,cr=0.5,ok=None,retries=20,evaluate=None):
  aa, bb, cc = any(all), any(all), any(all)
  tmp= o(objs=None,
         decs = [smear1(a,b,c,f,cr,log.space.lo[n],log.space.hi[n])
                   for n,(a,b,c)
                   in enumerate(zip(aa.decs,
                                    bb.decs,
                                    cc.decs))])
  if ok:
    assert retries>0,'too hard to satisfy constraints'
    if not ok(tmp):
      return smear(all,log=log,f=f,cf=cf,ok=ok,
                   retries=retries-1,
                   evaluate=evaluate)
  return evaluate(tmp) if evaluate else tmp

def smear1(a,b,c,f,cr,lo,hi):
  return bound(a + f*(b - c) if r()< cr else a, lo, hi)

