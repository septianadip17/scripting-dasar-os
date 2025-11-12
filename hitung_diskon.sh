#!/bin/bash

# Fungsi untuk format angka menjadi Rupiah sederhana
format_rupiah() {
  echo "Rp $1"
}

while true; do
  echo "Masukkan Nama Produk: "
  read nama_produk

  echo "Masukkan Harga Produk: "
  read harga

  echo "Masukkan Diskon (%): "
  read diskon

  # Validasi input sederhana
  if [[ -z "$nama_produk" || -z "$harga" || -z "$diskon" ]]; then
    echo "Input tidak boleh kosong."
    continue
  fi

  if (( harga <= 0 )); then
    echo "Harga harus lebih besar dari 0."
    continue
  fi

  if (( diskon < 0 || diskon > 100 )); then
    echo "Diskon harus antara 0–100."
    continue
  fi

  # Hitung potongan dan harga akhir
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

  # Tanya apakah mau menghitung lagi
  read -p "Apakah ingin menghitung produk lain? (y/n): " ulang
  if [[ "$ulang" != "y" && "$ulang" != "Y" ]]; then
    echo "Selesai."
    break
  fi

  echo
done
