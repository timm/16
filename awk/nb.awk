BEGIN { FS=","; Id=0}

function array0(a,i) {
    a[i][""]
    delete a[i][""]
}
function id(i) {
     if (i == "") i = Id = Id + 1;
     return i
}
function num0(_Num,  i) {
    i = id(i)
    txt[i] = ""
    n[i]   = mu[i] = m2[i] = 0
    lo[i]  =  10^32
    up[i]  = -10^32
    return i
}
function sym0(_Sym,  i) {
    i = id(i)
    txt[i]  = ""
    n[i]    = 0
    most[i] = 0
    mode[i] = ""
    array0(count,i)
    return i
}
function sym1(c,x,_Sym,   new) {
    n[c]++    
    counts[c][x]++
    new = counts[c][x]
    if (new > most[c]) {
        most[c] = new
        mode[c] = x }   
}
function num1(c,x,_Num,   delta) {
    if (n > up[c]) up[c] = n
    if (n < lo[c]) lo[c] = n
    delta = x - mu[c]
    mu[c] += delta / n[c]
    m2[c] += x - mu[c]
}
function sd(c,_Num) {
    return (m2[c] / (n[c] - 1))^0.5
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
