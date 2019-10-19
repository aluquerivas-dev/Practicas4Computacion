cat << end | gnuplot
set terminal postscript eps color
set output "$1.eps"
set key right bottom
set xlabel "Iteraciones"
set ylabel "CCR"
plot "log.txt" using 1 t "CCR TRAIN" w l lt rgb "red","log.txt" using 2 t "CCR TEST" w l lt rgb "blue","log.txt" using 3 t "VALIDATION ERROR" w l lt rgb "orange"
end