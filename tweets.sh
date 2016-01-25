#!/bin/bash

size() {
	cat - | gawk 'BEGIN {RS=""; FS="\n"} { 
                      print "\n" length($0) "\n" $0 }'
}

cat <<EOF | size
#dontWatch #awful DC's Legends of Tomorrow, pilot episode. An hour
of my life I'll never get back. http://buff.ly/1OF8RA5

#greenSE #fav2015papers. Equations for "beauty" (eqns 4 to 9).
Optimizes for max beauty and min power. Tee hee. http://buff.ly/1OF9QAr

#soSane #fav2015papers. Not 1 size fits all but mining tuned to
specific business flows. http://buff.ly/1ZTbXJg http://buff.ly/1ZTbXch

Great resource for #ethics + #SE. http://buff.ly/1Jrguv6. Good fuel
for my fall subject "Foundations of Software Science".  
EOF
