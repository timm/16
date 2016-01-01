from __future__ import print_function, division
import  sys 
sys.dont_write_bytecode = True
from lib import *



def ediv(lst, lvl=0,tiny=The.tree.min,
         dull=The.math.brink.cohen,
         num=lambda x:x[0], sym=lambda x:x[1]):
  "Divide lst of (numbers,symbols) using entropy."""
  #----------------------------------------------
  #print watch
  def divide(this,lvl): # Find best divide of 'this' lst.
    def ke(z): return z.k()*z.ent()
    lhs,rhs   = Sym(), Sym(sym(x) for x in this)
    n0,k0,e0,ke0= 1.0*rhs.n,rhs.k(),rhs.ent(),ke(rhs)
    cut, least  = None, e0
    last = num(this[0])
    for j,x  in enumerate(this): 
      rhs - sym(x); #nRhs - num(x)
      lhs + sym(x); #nLhs + num(x)
      now = num(x)
      if now != last:
        if lhs.n > tiny and rhs.n > tiny: 
          maybe= lhs.n/n0*lhs.ent()+ rhs.n/n0*rhs.ent()       
          if maybe < least : 
            gain = e0 - maybe
            delta= log2(3**k0-2)-(ke0- ke(rhs)-ke(lhs))
            if gain >= (log2(n0-1) + delta)/n0: 
              cut,least = j,maybe
      last= now
    return cut,least
  #--------------------------------------------
  def recurse(this, cuts,lvl):
    cut,e = divide(this,lvl)
    if cut: 
      recurse(this[:cut], cuts, lvl+1); 
      recurse(this[cut:], cuts, lvl+1)
    else:   
      lo    = num(this[0])
      hi    = num(this[-1])
      cuts += [Thing(at=lo, 
                     e=e,_has=this,
                     range=(lo,hi))]