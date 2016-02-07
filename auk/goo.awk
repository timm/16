function nchar(n,char) {
    char = char ? char : "*"
    s=""
    while (n-- > 0) s=s char
    return s
}
BEGIN{ print nchar(4) ; exit}
    
BEGIN { FS=""
        RS="sOme" "THINGSilly" }
      { xpand($0) }


function rparams(str,i,   lvl) {
    i = i ? i : 1
    for(j=i;j<=lenght(str); j++) {
        c=substr(str,j,j)
        if (c=="(") { 
            j = rparams(str,j+1,  lvl+1)  - 1
        }
    }}

function xpand(body,    i,n,str,pre,lines) {
    
    n = split(body,lines,/\n/)
    print length(body),n
    i = 1
    while (i <= n) {
        line = lines[i]
        if (line ~ /^function/) {
            str = pre = ""
            do  {
                str = str pre line
                pre = "\n"
                line = lines[++i]
            } while ( line !~ /^\}/ )
            print FUNCTION(str "\n}")
            exit
        } else {
            print line
            i += 1 }}
}

function FUNCTION(str,  arr) {
    match(str,/^[\s]*function[ \t]+([^\(]+)\(([^\)]*)\)(.*)$/,arr)
    print "function "arr[1]"("arr[2]",_)",arr[3]
}
      
#/function ([_a-zA-Z0-9]+)?::[_a-zA-Z0-9]+ ( / { def($2); skip }
#/::/  { call($0) } 

function def(method,   a,f) {
    split(method, a,"::")
    if (a[1]) Klass = a[1]
    f = a[2]
    sub(/::/,"_",method)
    GoTo[Klass][f] = method
}
#function call(line) {
#    gensub(/\y(\S+)\y::\y(\S+)\y(/,"&
#}
# function aa!open(x,y,z) {
#     x!fred(1,2)
#     do(x["?"],"fred",x,1,2)
# }

function o(l,prefix,   indent,   i) {
  if(! isarray(l)) {
    print "not array",prefix,l
    return 0}
   PROCINFO["sorted_in"]= "@ind_str_asc"
   for(i in l) 
     if (isarray(l[i])) {
       print indent prefix "[" i "]"
       o(l[i],"",indent "|   ")
     } else
       print indent prefix "["i"] = (" l[i] ")"
}

