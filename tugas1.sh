#!/usr/bin/env bash
# app.sh
# Mini project: Contact Manager CLI
# Syarat: implementasi operator, variabel, fungsi, array, input/output, loop, kondisi, validasi, warna

DB_FILE="contacts.db"
declare -a CONTACTS  # setiap item: nama|umur|telepon

# Warna ANSI
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"
BOLD="\e[1m"

# Fungsi: load data dari file ke array
load_data() {
  CONTACTS=()
  if [[ -f "$DB_FILE" ]]; then
    while IFS= read -r line || [[ -n "$line" ]]; do
      # skip baris kosong
      [[ -z "$line" ]] && continue
      CONTACTS+=("$line")
    done < "$DB_FILE"
  fi
}

# Fungsi: simpan array ke file
save_data() {
  : > "$DB_FILE"
  for item in "${CONTACTS[@]}"; do
    echo "$item" >> "$DB_FILE"
  done
}

# Fungsi: validasi nama
validate_name() {
  local name="$1"
  if [[ -z "$name" ]]; then
    echo "0"
    return
  fi
  # cek duplicate
  for item in "${CONTACTS[@]}"; do
    local n="${item%%|*}"
    if [[ "$n" == "$name" ]]; then
      echo "dup"
      return
    fi
  done
  echo "1"
}

# Fungsi: validasi umur
validate_age() {
  local age="$1"
  if [[ -z "$age" ]]; then
    echo "0"
    return
  fi
  if ! [[ "$age" =~ ^[0-9]+$ ]]; then
    echo "0"
    return
  fi
  # usia wajar 0-150
  if (( age < 0 || age > 150 )); then
    echo "0"
    return
  fi
  echo "1"
}

# Fungsi: tambah kontak. Menerima parameter (nama umur telepon)
add_contact() {
  local name="$1"
  local age="$2"
  local phone="$3"

  # jika dipanggil tanpa parameter, minta input interaktif
  if [[ -z "$name" ]]; then
    read -p "Nama: " name
  fi
  if [[ -z "$age" ]]; then
    read -p "Umur: " age
  fi
  if [[ -z "$phone" ]]; then
    read -p "Telepon: " phone
  fi

  # validasi
  local vname
  vname=$(validate_name "$name")
  if [[ "$vname" == "0" ]]; then
    echo -e "${RED}Nama tidak boleh kosong${RESET}"
    return 1
  fi
  if [[ "$vname" == "dup" ]]; then
    echo -e "${YELLOW}Dupikasi nama. Gunakan nama lain${RESET}"
    return 2
  fi
  if [[ "$(validate_age "$age")" != "1" ]]; then
    echo -e "${RED}Umur harus angka 0-150${RESET}"
    return 1
  fi

  CONTACTS+=("$name|$age|$phone")
  save_data
  echo -e "${GREEN}Kontak ditambahkan: $name${RESET}"
  return 0
}

# Fungsi: tampilkan daftar kontak
list_contacts() {
  if [[ ${#CONTACTS[@]} -eq 0 ]]; then
    echo -e "${YELLOW}Belum ada kontak.${RESET}"
    return
  fi
  printf "%s\n" "${BLUE}Daftar Kontak:${RESET}"
  local i=1
  for item in "${CONTACTS[@]}"; do
    IFS='|' read -r n a p <<< "$item"
    printf "%2d. %s | Umur: %s | Tel: %s\n" "$i" "$n" "$a" "$p"
    ((i++))
  done
}

# Fungsi: cari kontak by nama
find_contact() {
  local key="$1"
  if [[ -z "$key" ]]; then
    read -p "Masukkan nama atau bagian nama untuk cari: " key
  fi
  local found=0
  for item in "${CONTACTS[@]}"; do
    IFS='|' read -r n a p <<< "$item"
    if [[ "${n,,}" == *"${key,,}"* ]]; then
      echo -e "${GREEN}$n | Umur: $a | Tel: $p${RESET}"
      found=1
    fi
  done
  if [[ $found -eq 0 ]]; then
    echo -e "${YELLOW}Tidak ditemukan.${RESET}"
  fi
}

# Fungsi: hapus kontak. parameter: indeks atau nama
delete_contact() {
  local target="$1"
  if [[ -z "$target" ]]; then
    read -p "Masukkan nomor atau nama kontak yang ingin dihapus: " target
  fi
  # jika angka, hapus berdasarkan indeks
  if [[ "$target" =~ ^[0-9]+$ ]]; then
    local idx=$((target-1))
    if (( idx < 0 || idx >= ${#CONTACTS[@]} )); then
      echo -e "${RED}Indeks tidak valid${RESET}"
      return 1
    fi
    local removed="${CONTACTS[$idx]}"
    unset 'CONTACTS[idx]'
    CONTACTS=("${CONTACTS[@]}")
    save_data
    echo -e "${GREEN}Kontak dihapus: ${removed%%|*}${RESET}"
    return 0
  fi
  # jika string, cari dan hapus yang cocok persis
  local new=()
  local deleted=0
  for item in "${CONTACTS[@]}"; do
    IFS='|' read -r n a p <<< "$item"
    if [[ "$n" == "$target" && $deleted -eq 0 ]]; then
      deleted=1
      continue
    fi
    new+=("$item")
  done
  if [[ $deleted -eq 1 ]]; then
    CONTACTS=("${new[@]}")
    save_data
    echo -e "${GREEN}Kontak dihapus: $target${RESET}"
    return 0
  else
    echo -e "${YELLOW}Kontak tidak ditemukan${RESET}"
    return 1
  fi
}

# Fungsi: statistik sederhana (operator aritmatika)
show_stats() {
  local total=${#CONTACTS[@]}
  if (( total == 0 )); then
    echo -e "${YELLOW}Tidak ada data untuk statistik${RESET}"
    return
  fi
  local sum=0
  for item in "${CONTACTS[@]}"; do
    IFS='|' read -r n a p <<< "$item"
    sum=$(( sum + a ))
  done
  # hitung rata-rata umur. gunakan pembagian integer
  local avg=$(( sum / total ))
  echo -e "${BLUE}Statistik:${RESET}"
  echo -e "Jumlah kontak: $total"
  echo -e "Total umur: $sum"
  echo -e "Rata-rata umur (int): $avg"
}

# Tampilan menu utama
main_menu() {
  while true; do
    echo
    echo -e "${BOLD}Aplikasi Kontak - Menu${RESET}"
    echo "1. Tambah kontak"
    echo "2. Daftar kontak"
    echo "3. Cari kontak"
    echo "4. Hapus kontak"
    echo "5. Statistik"
    echo "6. Contoh tambah cepat (demo operators)"
    echo "0. Keluar"
    read -p "Pilih nomor: " choice

    case "$choice" in
      1)
        add_contact
        ;;
      2)
        list_contacts
        ;;
      3)
        find_contact
        ;;
      4)
        list_contacts
        delete_contact
        ;;
      5)
        show_stats
        ;;
      6)
        demo_operations
        ;;
      0)
        echo -e "${GREEN}Sampai jumpa${RESET}"
        exit 0
        ;;
      *)
        echo -e "${RED}Pilihan tidak valid${RESET}"
        ;;
    esac
  done
}

# Fungsi demo untuk menunjukkan operator aritmatika dan perbandingan
demo_operations() {
  echo "Demo operator:"
  local a=10
  local b=3
  echo "a = $a, b = $b"
  echo "a + b = $(( a + b ))"
  echo "a - b = $(( a - b ))"
  echo "a * b = $(( a * b ))"
  echo "a / b = $(( a / b ))  (pembagian integer)"
  if (( a > b )); then
    echo "a lebih besar dari b"
  else
    echo "a tidak lebih besar dari b"
  fi
}

# Inisialisasi
load_data

# Pesan pembuka
echo -e "${GREEN}Selamat datang di Aplikasi Kontak CLI${RESET}"
main_menu
