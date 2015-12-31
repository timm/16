from __future__ import print_function, division
import  sys 
sys.dont_write_bytecode = True
from lib import *
from counts import *

@setting
def CSV(): return o(
    whitespace = r"[\n\r\t ]*",
    comment    = r"#.*",
    delimiter  = ",",
    ignore     = "?",
    missing    = '?',
    klass      = "=",
    less       = "<",
    more       = ">",
    float      = "$",
    int        = ":"
    )

def ignorep(x):
  return the.CSV.ignore in x
def intp(x): 
  return the.CSV.int in x
def floatp(x):
  return the.CSV.float in x
def nump(x):
  return intp(x) or floatp(x)  \
         or the.CSV.more in x or the.CSV.less in x
def goalp(x):
  return the.CSV.less in x or the.CSV.more in x \
         or the.CSV.klass in x

##########################################
# iterators for reading lines

def STRING(str):
  for line in str.splitlines(): 
    yield line

def ZIP(zip,file):
  with zipfile.ZipFile(zip, 'r') as z:
    with z.open(file) as f:
      for line in f: 
        yield line

def FILE(filename):
  with open(filename) as f:
    for line in f: 
      yield line

##########################################
# iterators for reading lines

def rows(src):
  b4 = ''
  for line in src:
    line = re.sub(the.CSV.whitespace,"",line)
    line = re.sub(the.CSV.comment,   "",line)
    if not line: continue # skip blanks
    if line[-1] == the.CSV.delimiter: # maybe, continue lines
      b4 += line
    else:
      yield b4 + line
      b4 = ''

def cols(src):
  def make(x,f): 
    return x if ignorep(x) else f(x) 
  def maker(x):
    if intp(x)  : return int
    if nump(x): return float
    return identity
  #------
  want = None
  for row in rows(src):
    lst  = row.split(the.CSV.delimiter)
    if want:
      yield [make(lst[col],how) for col,_,how in want]
    else:
      want = [(col,name,maker(name))
               for col,name in enumerate(lst)
               if not ignorep(name) ]
      yield [name for col,name, how,in want] 

##########################################
# some test data in a string

datastring="""
                    # bogus blank line
  outlook,
  $temperature,     # row1 broken by newlines, twice
  $humidity,?windy,>play
  sunny    , 85, 85, FALSE, 0  # an interesting case
  sunny    , 80, 90, TRUE , 0
  overcast , 83, 86, FALSE, 2
  rainy    , 70, 96, FALSE, 3
  rainy    , 68, 80, FALSE, 4
  rainy    , 65, 70, TRUE , 0
  overcast , 64, 65, TRUE ,      # bogus format
  4
  sunny    , 72, 95, FALSE, 0    # bogus blank line, next
  
  sunny    , 69, 70, FALSE, 4
  rainy    , 75, 80, FALSE, 5
  sunny    , 75, 70, TRUE , 6
  overcast , 72, 90, TRUE , 5
  overcast , 81, 75, FALSE, 4
  rainy    , 71, 91, TRUE , 0"""

def _csv():
  def worker(src):
    for n,one in enumerate(src):
      print(n,"{",one,"}",sep='')
  def csva():
    worker(STRING(datastring))
  def csvrows():
    worker(rows(STRING(datastring)))
  def csvcols():
    worker(cols(STRING(datastring)))
  ok(csva,csvrows,csvcols)
  
###########################################
# a table is a header plus a list of rows

class table:
  def __init__(i,src):
    i.rows=[]
    i.header=None
    i.dep, i.indep, i.sym, i.num = {},{},{},{}
    for j,cells in enumerate(src):
      if j:
        i.rows += [row(t,cells)]
      else:
        i.header = cells[:]
        for k,h in enumerate(i.header):
          what1= i.dep if goalp(h) else i.indep 
          what2= i.num if nump(h)  else i.sym
          what1[k] = what2[k] = h
  def klass(i):
    for k in i.dep:
      return k,i.dep[v]

class row:
  n=0
  def __init__(i,t,cells):
    i.n = row.n = row.n+1
    i.raw = cells
    i.cooked = []
    i.table = t
    i.rnn, i.neighbors = 0, {}
  def all(i,what):
    return [z.cooked[k] for k in what]
  def overlap(i,j):
    return len( set( i.all(i.indep) ) and
                set( j.all(j.indep) ) )

def rnn(rows): 
  for j,row1 in enumerate(rows): 
    for row2 in rows[j:]:
      tmp = row1.overlap(row2)
      row1.neighbors +=  [(tmp,row2)]
      row2.neighbors +=  [(tmp,row1)] 
  for row1 in rows:
    row1.neighbors = reverse(sorted(row1.neighbors))
    first = row1.neighbors[0][0]
    for dist1,row2 in row1.neighbors:
      if dist1 == first:
        row2.rnn += 1
      else:
        break

def _table():
  t= table(cols(STRING(datastring)))
  assert t.dep=={3:'>play'}
  assert t.indep=={0:'outlook', 1:'$temperature', 
                     2:'$humidity'}
  assert t.num=={1:'$temperature',2:'$humidity',3:'>play'}
  assert t.sym=={0:'outlook'}
  assert len(t.rows)==14 

__name__ == '__main__' and ok(_csv,_table)