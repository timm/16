from __future__ import print_function, division
import  sys 
sys.dont_write_bytecode = True
from table import *
from counts import *

@setting
def CUT(): return o(
  crowded=4,
  cohen=0.1,
  fayyad=False
)

def crowded(x):
  return n >= the.CUT.crowded

def smallEffectSize(lst,num):
  return Num(num(z) for z in lst).sd()*the.CUT.cohen
  
def recurse(this, divisor, id, x,cuts):
    cut,about = divisor(this)
    if cut:
      recurse(this[:cut], divisor, id,x, cuts);
      recurse(this[cut:], divisor, id,x, cuts)
    else:
      cuts += [o( id = id,
                  n = len(cuts),
                  x  = o(lo=x(this[0]), hi=x(this[-1])),
                  y  = about,
                  has= this)]
    return cuts

def spliters(this,lhs,rhs,x,y,small):
  def silly():
    if x(this[j]) - x(this[0]) < small:  return True
    if j + 1  < len(this):
      if x(this[j+1]) - x(this[j]) < small: return True
    return False
  for j,one in enumerate(this):
    if lhs.n > the.CUT.crowded and rhs.n > the.CUT.crowded:
        if not silly():   
          yield j,one
    rhs -= y(one)
    lhs += y(one)

def sdiv1(lst,x=None,**d): return sdiv(lst,x=x,y=x,**d)
  
def sdiv(lst, id=0, small=None,
         x= lambda z:z[0],
         y= lambda z:z[-1]):
  def sdivide(this): #Find best divide of 'this'
    lhs,rhs = Num(), Num(y(z) for z in this)
    n0, sd0, cut, mu = rhs.n, rhs.sd(), None, rhs.mu
    score = sd0
    for j,one  in spliters(this,lhs,rhs,x,y,small):
      maybe= lhs.n/n0*lhs.sd()+ rhs.n/n0*rhs.sd()
      if maybe < score:
        if abs(lhs.mu - rhs.mu) >= small:
          cut,score = j,maybe
    return cut, o(mu=mu,n=n0,sd=sd0)
  if not lst: return []
  small = small or smallEffectSize(lst,x)
  return recurse(sorted(lst,key=x),  
                 sdivide, id, x, [] ) 

def ediv(lst, id=0, small=None,
         num= lambda x:x[0], 
         sym= lambda x:x[1]):
  def edivide(this):  
    def ke(z): return z.k()*z.ent()
    lhs,rhs   = Sym(),Sym(sym(x) for x in this) 
    n0,k0,e0,ke0= rhs.n,rhs.k(),rhs.ent(),ke(rhs)
    cut, least  = None, e0
    for j,one  in spliters(this,lhs,rhs,num,sym,small):
      maybe= lhs.n/n0*lhs.ent()+ rhs.n/n0*rhs.ent()
      if maybe < least :
        if the.CUT.fayyad:
          gain  = e0 - maybe
          delta = log2(3**k0 -2)- (ke0 - ke(rhs) - ke(lhs))
          if gain >= (log2(n0 - 1) + delta)/n0:
              cut,least = j,maybe
        else:
          cut,least = j,maybe
    return cut,o(n=n0,e=e0)
  if not lst: return []
  small = small or smallEffectSize(lst,num)
  return recurse(sorted(lst,key=num), 
                 edivide, id, num, [])

t = table(cols(FILE('data/albrecht.csv')))

klasses= sdiv1(t.rows,  x= lambda z:z.raw[-1]) 

for row in t.rows: 
  row.cooked = row.raw[:] 
for klass in klasses:
  k = klass.n
  for row in klass.has:
    row.cooked[-1] =  k

for n in t.inNums:
  for r in ediv(t.rows, 
                  num =lambda z:z.raw[n],
                  sym =lambda z:z.cooked[-1]):
    print("\n",n,r.x,len(r.has),r.y)

#print(len(t.rows))
## print("\n",x)

def _ediv():
  "Demo code to test the above."
  import random
  bell= random.gauss
  random.seed(1)
  def go(lst):
    print(""); print(sorted(lst)[:],"...")
    d = ediv(lst)
    print(d[0][1][0][0])

    print(d[0] ,"d[0]")
    print(d[1] ,"d[1]")
    print(d[0][1], "d[0][1]")
    print(d[0][1][0], "d[0][1][0]")
    print(d[0][1][0][0], "d[0][1][0][0]")

    for d in  ediv(lst):
      print(d[1][0])
  X,Y="X","Y"
  l=[(1,X),(2,X),(3,X),(4,X),(11,Y),(12,Y),(13,Y),(14,Y)]
  #l=[(3.02,'x'),(3.05,'x'),(3.03,'x'),(4.00,'y'),(4.01,'x'),(4.02,'y')]
  go(l)
  """  go(l)
  l[0] = (1,Y)
  go(l)
  go(l*2)
  go([(1,X),(2,X),(3,X),(4,X),(11,X),(12,X),(13,X),(14,X)])

  go([(64,X),(65,Y),(68,X),(69,Y),(70,X),(71,Y),
      (72,X),(72,Y),(75,X),(75,X),
      (80,Y),(81,Y),(83,Y),(85,Y)]*2)
  l=[]
  for _ in range(1000):
    l += [(bell(20,1),  X),(bell(10,1),Y),
          (bell(30,1),'Z'),(bell(40,1),'W')]
  go(l)
  go([(1,X)])
  """
#__name__ == '__main__' and _ediv()

"""
Output:

[(1, 'X'), (2, 'X'), (3, 'X'), (4, 'X'),
 (11, 'Y'), (12, 'Y'), (13, 'Y'), (14, 'Y')] ...
1
11

[(1, 'Y'), (2, 'X'), (3, 'X'), (4, 'X'),
 (11, 'Y'), (12, 'Y'), (13, 'Y'), (14, 'Y')] ...
1

[(1, 'Y'), (1, 'Y'), (2, 'X'), (2, 'X'),
 (3, 'X'), (3, 'X'), (4, 'X'), (4, 'X'), (11, 'Y'), (11, 'Y')] ...
1
11

[(1, 'X'), (2, 'X'), (3, 'X'), (4, 'X'),
 (11, 'X'), (12, 'X'), (13, 'X'), (14, 'X')] ...
1

[(64, 'X'), (64, 'X'), (65, 'Y'), (65, 'Y'),
 (68, 'X'), (68, 'X'), (69, 'Y'), (69, 'Y'), (70, 'X'), (70, 'X')] ...
64
80

[(6.900378121061215, 'Y'), (7.038785729480842, 'Y'),
 (7.31690058848835, 'Y'), (7.359039915634471, 'Y'),
 (7.364480069138072, 'Y'), (7.553496312538384, 'Y'),
 (7.581606303196569, 'Y'), (7.651878578401048, 'Y'),
 (7.655341871448137, 'Y'), (7.677081766167625, 'Y')] ...
6.90037812106
16.907507693
26.850034984
36.8600218357

[(1, 'X')] ...
1



"""
