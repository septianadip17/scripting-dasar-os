#!/bin/bash

format_rupiah() {
  echo "Rp $1"
}

while true; do
  read -p "Masukkan Nama Produk: " nama_produk
  read -p "Masukkan Harga Produk: " harga
  if (( harga <= 0 )); then
    echo "Harga harus lebih besar dari 0."
    continue
  fi
  read -p "Masukkan Diskon (%): " diskon


  # validasi input
  if [[ -z "$nama_produk" || -z "$harga" || -z "$diskon" ]]; then
    echo "Input tidak boleh kosong."
    continue
  fi


  if (( diskon < 0 || diskon > 100 )); then
    echo "Diskon harus antara 0–100."
    continue
  fi


  # hitung diskon
  potongan=$(( harga * diskon / 100 ))
  harga_akhir=$(( harga - potongan ))

  echo
  echo "=== Detail Diskon ==="
  echo "Nama Produk    : $nama_produk"
  echo "Harga Awal     : $(format_rupiah $harga)"
  echo "Diskon         : $diskon%"
  echo "Potongan Harga : $(format_rupiah $potongan)"
  echo "Harga Akhir    : $(format_rupiah $harga_akhir)"
  echo

  read -p "Apakah ingin menghitung produk lain? (y/n): " ulang
  if [[ "$ulang" != "y" && "$ulang" != "Y" ]]; then
    echo "Selesai."
    break
  fi

  echo
done
