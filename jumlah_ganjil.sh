#!/bin/bash
data=(3 6 7 8 9 11 4 9 5 2 2 4 6 6)

sum_ganjil=0
count_ganjil=0

echo "Nilai ganjil:"

for angka in "${data[@]}"; do
  if (( angka % 2 != 0 )); then
    echo -n "$angka "
    (( sum_ganjil += angka ))
    (( count_ganjil++ ))
  fi
done

echo
echo "Total jumlah nilai ganjil: $count_ganjil"
echo "Jumlah semua nilai ganjil (penjumlahan): $sum_ganjil"
