# Sway
from __future__ import print_function, division
import  sys 
sys.dont_write_bytecode = True 

from model import *
from space import *

class Kursawe(Model):
  n = 3
  a=2
  b=3
  def about(i):
    def f1(x):
      return  sum( -10 * ee ** ( -0.2 * sqrt(z**2 + x.decs[i+1]**2))
                  for i,z in enumerate(x.decs[:-1]))
    def f2(x):
      a,b= Kursawe.a, Kursawe.b
      return sum( abs(z)**a + 5 * math.sin(z)**b
                  for z in x.decs)
    def dec(x):
      return An(x,lo= -5,hi=5)
    i.decs = [dec(x) for x in range(Kursawe.n)]
    i.objs = [Less("f1",maker=f1),
              Less("f2",maker=f2)]
              
class ZDT1(Model):
  n=30
  def about(i):
    def f1(x):
      return x.decs[0]
    def f2(x):
      g = 1 + 9 * sum(x for x in x.decs[1:] )/(ZDT1.n-1)
      return  g * abs(1 - sqrt(x.decs[0]/g))
    def dec(x):
      return An(x,lo=0,hi=1)
    i.decs = [dec(x) for x in range(ZDT1.n)]
    i.objs = [Less("f1",maker=f1),
              Less("f2",maker=f2)]


def DTLZ7_2_3(): return DTLZ7()
def DTLZ7_4_5(): return DTLZ7(5)
def DTLZ7_6_7(): return DTLZ7(7)


class DTLZ7(Model):
  def __init__(i,nobjs=3):
    i.ndecs, i.nobjs = nobjs-1,nobjs
    Model.__init__(i)
  def g(i,x):
    return 1 + 9/i.nobjs * sum(x.decs)
  def h(i,x,g):
    _h = i.nobjs
    for j in range(i.nobjs-1):
      _f  = i.f("a",j,x)
      _h -=  _f /(1 + g) * (
              1 + math.sin(3 * pi * _f))
    return _h
  def f(i,s,j,x):
    if j < (i.nobjs - 1):
      return x.decs[j]
    else:
      _g = i.g(x)
      return (1+ _g) * i.h(x,_g)
  def about(i):
    def obj(j):
      return lambda x: i.f("x",j,x)
    def dec(x):
      return An(x,lo=0,hi=1)
    i.decs = [dec(x) for x in range(i.ndecs)]
    i.objs = [Less("f%s" % j,
                   maker=obj(j))
                   for j in range(i.nobjs)]
    #XXX complete dtlz7


class Fonseca(Model):
  n=3
  def about(i):
    def f1(can):
      z = sum([(x - 1/sqrt(Fonseca.n))**2 for x in can.decs])
      return 1 - ee**(-1*z)
    def f2(can):
      z = sum([(x + 1/sqrt(Fonseca.n))**2 for x in can.decs])
      return 1 - ee**(-1*z)
    def dec(x):
      return An(x, lo=-4, hi=4)
    i.decs = [dec(x) for x in range(Fonseca.n)]
    i.objs = [Less("f1",  maker=f1),
              Less("f2",  maker=f2)]    

class Viennet4(Model):
  n=2
  def ok(i,can):
     one,two = can.decs
     g1 = -1*two - 4*one + 4
     g2 = one + 1            
     g3 = two - one + 2
     return g1 >= 0 and g2 >= 0 and g3 >= 0
  def about(i):
    def f1(can):
      one,two = can.decs
      return (one - 2)**2 /2 + (two + 1)**2 /13 + 3
    def f2(can):
      one,two = can.decs
      return (one + two - 3)**2 /175 + (2*two - one)**2 /17 - 13
    def f3(can):
      one,two= can.decs
      return (3*one - 2*two + 4)**2 /8 + (one - two + 1)**2 /27 + 15
    def dec(x):
      return An(x,lo= -4,hi= 4)
    i.decs = [dec(x) for x in range(Viennet4.n)]
    i.objs = [Less("f1",maker=f1),
              Less("f2",maker=f2),
              Less("f3",maker=f3)] 
 
########### test cases

def _models(repeats=32,items=32):
  def worker(m):
    x = m.eval(m.decide())
    logDecs + x
    logObjs + x
    return x
  reset() 
  for f in [Fonseca,Viennet4,ZDT1, DTLZ7_2_3,DTLZ7_4_5]:
    m = f()
    logDecs = Space(value=decisions)
    logObjs = Space(value=objectives)
    print("")
    for _ in xrange(repeats):
      say(".")
     
      all = [worker(m) for _ in xrange(items)]
      one = all[0]
      
      far,d1 = logDecs.furthest(one,all)
      near,d2= logDecs.closest(one,all)
      assert d2 < d1
      
      far,d3 = logObjs.furthest(one,all)
      near,d4= logObjs.closest(one,all)
      assert d4 < d3
  print("")
      
    
def _Viennet4():
  reset()
  m = Viennet4()
  x = m.eval(m.decide()) 
  assert {'objs' :  [5.101, -12.897, 17.829], 
          'decs' :  [-0.037, -0.404]} \
            == {'decs' : r3s(x.decs), 'objs': r3s(x.objs)}
 
def _tournament(repeats=16,items=512):
  def worker(m):
    x = m.eval(m.decide())
    logDecs + x
    logObjs + x
    return x
  reset() 
  models= [ZDT1,Fonseca,Kursawe]
  for f in models:
    m = f()
    logDecs = Space(value=decisions)
    logObjs = Space(value=objectives) 
    all = [worker(m) for _ in xrange(items)]
    some = tournament(m,all,logObjs) 
    xs,ys=[],[]
    for one in sorted(some,key=lambda z:z.objs):
        xs += [one.objs[0]]
        ys += [one.objs[1]]
    print(len(some))
    textplot(data(xs), data(ys), 
          xlabel="x= obj1", 
          title="y= obj2 for %s" % f.__name__, 
          cmds="set key top left") 
  print("")
  
 
            
  
main(__name__,_models, _Viennet4,_tournament)
