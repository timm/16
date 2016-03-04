

function _readcsv(      w) {
  if (args("-d,data/weather.csv,--dump,0",o)) {
    readcsv("cat " w["o"]["-d"], w)
    if (w["o"]["--dump"])
      dumpcsv(w) }
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
