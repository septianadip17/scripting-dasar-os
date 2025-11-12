#!/bin/bash

# Data
data=(3 6 7 8 9 11 4 9 5 2 2 4 6 6)

# Variabel penghitung jumlah bilangan ganjil
jumlah_ganjil=0

echo "Nilai ganjil:"

# Loop untuk cek setiap angka
for angka in "${data[@]}"; do
  if (( angka % 2 != 0 )); then
    echo -n "$angka "
    (( jumlah_ganjil++ ))
  fi
done

echo
echo "Total jumlah nilai ganjil: $jumlah_ganjil"
