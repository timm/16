#--------------------------------------
# start up
BEGIN { FS=","; Id=0; seed() }

#--------------------------------------
# lib

# maths
function seed(z)  { srand( z ? z : 1 )     }
function round(z) { return int(z + 0.5)    }
function log2(z)  { return log(z) / log(2) }
function max(y,z) { return y > z ? y : z   }
function min(y,z) { return y < z ? y : z   }

# lists
function last(a)   { return a[ length(a) ] }
function push(a,z) { a[ length(a)+1 ] = z; return z }

function array0(a,i) {
  a[i][""]
  delete a[i][""]
}

# objects
function id(i) {
  if (i == "") i = Id = Id + 1;
  return i
}
#--------------------------------------
#_ Some max kept n

function some0(_Some, i) {
  i = id(i)
  max[i] = 256
  array0(kept,i)
  n[i] = 0
}    
function some1(i,z,_Some,   k) {
  n[i]++
  k = length(kept[i])
  if (k < max[i])
    return push(kept[i],z)
  if ( rand() < k/n[i] )
    kept[i][ round(rand()*k) ] = z }
}
#--------------------------------------
#_ Sym mode most counts name n

function sym0(_Sym,  i) {
  i = id(i)
  txt[i]  = ""
  n[i]    = 0
  most[i] = 0
  mode[i] = ""
  array0(count,i)
  return i
}
function sym1(i,z,_Sym,   new) {
  n[i]++    
  counts[i][x]++
  new = counts[i][z]
  if (new > most[i]) {
    most[i] = new
    mode[i] = z }   
}
function ent(i,_Sym,   k,z,p,e) {
  for(k in counts[i]) {
    z = counts[i][k]
    if (z > 0) {
      p  = f/n[i]
      e -= p*log2(p) } }
  return e
}
#--------------------------------------
#_ Num mu m2 n x name up lo

function num0(_Num,  i) {
  i = id(i)
  txt[i] = ""
  n[i]   = mu[i] = m2[i] = 0
  lo[i]  =  10^32
  up[i]  = -10^32
  return i
}
function num1(i,z,_Num,   delta) {
  if (n > up[i]) up[i] = n
  if (n < lo[i]) lo[i] = n
  n[i]  += 1
  delta  = z - mu[i]
  mu[i] += delta / n[i]
  m2[i] += z - mu[i]
}
function numun(i,z,_Num,  delta) {
  lo[i]  =    10^32
  hi[i]  = -1*10^32
  n[i]  -= 1
  delta  = z - mu[i]
  mu[i] -= delta/n[i]
  m2[i] -= delta*(z - mu[i])
}
function sd(i,_Num) {
  return (m2[i] / (n[i] - 1))^0.5
}
#----------------
#_ Out more less klass

# m[c][r] : columns before rows

function readcsv(com,m,_Num,_Sym,_Out,txt, \
                 cell,srows,i,use,_Num) {
  com = com ? com : "cat -"
  while((com | getline)  > 0)  {
    line = entireLine($0) 
    if (line) {
      split(line,cells0,",")
      rows++
      if (rows==1) {
        usable(cells0, use, cells)
        head(cells,m,use, _Num, _Sym, _Out)
      }
      else {
        using(cells0, use, cells)
        row( cells,m, rows-1, _Num, _Sym) }}}
}
function entireLine(line,   tmp) {
  gsub(/[ \t\r]/, "", line)
  gsub(/##.*/   , "", line)
  if ( line !~ /,$/ )
    return line
  if ((getline tmp) == 0)
    return line
  return line entireLine(tmp)
}
function row(cells,m,r, _Num,_Sym,  c) {
  for(c in cells) {
    if (c in lo) {
      cells[c] += 0
      num1(c, cells[c], _Num)
    } else
      sym1(c, cells[c], _Sym);
    m[r][c] = line[c]}
}
function head(line,m, _Num,_Sym, _Out,   c0,c) {
  for(c in line) {
    if ( $c ~ /^</ ) less[c]
    if ( $c ~ /^>/ ) more[c]
    if ( $c ~ /^=/ ) klass[c]
    txt[c] = line[c]
    if ( $c ~ /^_/ ) 
      num0(_Num, c)
    else
      sym0(_Sym,c) }
}
function using(cells0, use, cells) { 
  for(c in use)
    cells[c] = cells0[ uses[c] ]
}
function usable(cells0, use,cells,  c0,c) {
  max = length(cells0)
  for(c0=1; c0 <= max; c0++)
    if (cells0[c0] !~ /^X/) 
      use[++c] = c0;
  using(cells0,use,cells)
}
#--------------------------------------
#_ Split enough get cohen maxBins minBinSize small id trivial
#_ Range n col range lo up

function split0(i,_Split) {
  i = id(i)
  get[i]        = "last"
  enough[i]     = 4
  cohen[i]      = 0.2
  maxBins[i]    = 16
  minBinSize[i] = 4
  small[i]      = 1
  id[i]         = 1
  trivial[i]    = 1.05
  return i
}

function range0(i,_Range) {
  i = id(i)
  id[i]  = 1
  lo[i]  = 0
  hi[i]  = 1
  col[i] = 1
  bin[i] = 1
  return i
}

function split(i,m,c,_Splits,_Ranges,_Nums,  s,n,r) {
  s = split0(_Splits)
  n = num0(_Nums)
  for(r in m[c]) 
    num1( m[c][r], n, _Nums)
  small0 = max(minBinSizes[s], ns[n] / maxBinss[s] )
  enoughs[s] = enoughs[s] ? 
}
