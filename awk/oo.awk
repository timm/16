

function _readcsv(      _Rows,o) {
  if (args("-d,data/weather.csv,--dump,0",o)) {
      readcsv("cat " O{o}{d} , _Rows)
    if (o["--dump"])
      dumpcsv(_Rows) }
}
function readcsv(com, _Rows,fun,    rows,cols,line,i) {
  com = com ? com : "cat -"
  while((com | getline)  > 0)  {
    gsub(/[ \t\r]/,"")
    gsub(/##.*/,"")
    if ($0) {
      for(i=1;i<=NF;i++) 
	       line[i] = $i
      if (rows)
	       row(line,rows,cols, _Rows,fun) 
      else
	      header(line,cols,_Rows)
        rows++     
      delete line 
}}}
function dumpcsv(_Rows,    rows,row,cols,col,out) {
  rows=length(data)
  for(row=1;row<=rows;row++) {
    out = data[row][1]
    cols = length(data[row])
    for(col=2;col<=cols;col++)
      out = out "," data[row][col]
    print "["out"]" }
}
