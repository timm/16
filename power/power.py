from __future__ import print_function, division
import  sys 
sys.dont_write_bytecode = True

from divs import *

def power(src):
  t  = table(cols(src))
  # cook the klasses
  ks = sdiv1(t.rows,  x= lambda z:z.raw[-1]) 
  for k in ks:
    for row in k.has:
      row.cooked[-1] =  k.n
  # cook the numberic ranges
  for n in t.inNums:
    lst = ediv(t.rows, id = n,
                  num =lambda z:z.raw[n],
                  sym =lambda z:z.cooked[-1])
    for z in lst:
      z.w = z.y.score*z.y.n/len(t.rows)
    lst =  sorted(lst, key=lambda z: z.w)  
    if len(lst) > 1:
      best[n] = lst[0]
  for z in best.values():
     print(o(id=z.id, n=z.n, lo=z.x.lo, hi=z.x.hi, w=z.w))
    
__name__ == '__main__' and power(FILE('data/albrecht.csv'))