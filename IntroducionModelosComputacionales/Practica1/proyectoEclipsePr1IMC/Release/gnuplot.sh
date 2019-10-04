cat << end | gnuplot
set terminal postscript eps color
set output "$1.eps"
set key right bottom
set xlabel "Iteraciones"
set ylabel "MSE"
plot "log.txt" using 1 t "trainError" w l lt rgb "red","log.txt" using 2 t "validationError" w l lt rgb "blue","log.txt" using 3 t "testError" w l lt rgb "orange"
end