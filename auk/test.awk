function aa(x,y) { print x+ y}

BEGIN {
    x["a"]["b"]="aa"
    f1="aa"
    @x["a"]["b"](1,2)
}
