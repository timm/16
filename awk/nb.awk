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
function sym(c,x,_Sym,   new) {
    n[c]++    
    counts[c][x]++
    new = counts[c][x]
    if (new > most[c]) {
        most[c] = new
        mode[c] = x }   
}
function num(c,x,_Num,   delta) {
    if (n > up[c]) up[c] = n
    if (n < lo[c]) lo[c] = n
    delta = x - mu[c]
    mu[c] += delta / n[c]
    m2[c] += x - mu[c]
}
function sd(c,_Num) {
    return (m2[c] / (n[c] - 1))^0.5
}
function readcsv(com,m,_Num,_Sym,_Out,txt,    rows,i,_Num) {
  com = com ? com : "cat -"
  while((com | getline)  > 0)  {
    gsub(/[ \t\r]/,"")
    gsub(/##.*/,"")
    if ($0) {
        for(i=1;i<=NF;i++)
            line[i] = $i;
        if (rows)
            row(line,rows,m, _Num, _Sym)
        else
            header(line,r,m, _Num, _Sym, _Out);
        rows++ }}
}
function row(line,r,m, _Num,_Sym,  c) {
    for(c in line) {
        if (c in lo) {
            line[c] += 0
            num(c, line[c], _Num)
        } else
            sym(c, line[c], _Sym) 
        m[r][c] = line[c]}
}
function header(line,txt,_Num,_Sym, _Out,   c) {
    for(c in line)
        if ( $c ~ /^</ ) less[c]
        if ( $c ~ /^>/ ) more[c]
        if ( $c ~ /^=/ ) klass[c]
        if ( $c ~ /^X/ ) {
            txt[c] = line[c]
            if ( $c ~ /^_/ ) 
               num0(_Num, c)
            else
                sym0(_Sym,c) }
}
