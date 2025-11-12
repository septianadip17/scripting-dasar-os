# Panduan Lengkap Shell Script (.sh)

## 1. Apa itu File `.sh`

File **`.sh`** adalah **Shell Script**, yaitu file teks berisi kumpulan perintah yang dijalankan oleh **Shell** (seperti Bash, Zsh, atau Sh) pada sistem operasi **Unix/Linux**.

Shell Script digunakan untuk **mengotomatiskan pekerjaan** yang biasanya dilakukan manual di terminal.  
Contohnya:
- Menyalin atau memindahkan file otomatis  
- Menjalankan backup harian  
- Menginstal paket dan konfigurasi sistem  
- Men-deploy aplikasi ke server  

---

## 2. Fungsi dan Tujuan Shell Script

Shell Script dibuat agar pekerjaan di sistem berjalan **lebih cepat, konsisten, dan efisien**.  
Berikut fungsi utamanya:

1. **Otomatisasi**
   - Menjalankan serangkaian perintah tanpa intervensi manual.
   - Contoh: backup data harian atau update sistem otomatis.

2. **Efisiensi**
   - Menghemat waktu dengan menulis perintah sekali dan menjalankannya kapan saja.

3. **Manajemen Sistem**
   - Digunakan untuk monitoring server, konfigurasi, dan pengelolaan layanan.

4. **Prototyping Cepat**
   - Berguna membuat alat bantu sederhana sebelum dikembangkan dalam bahasa seperti Go atau Python.

---

## 3. Struktur Dasar File `.sh`

```bash
#!/bin/bash
# Baris pertama disebut shebang. Ini menentukan interpreter yang digunakan (bash shell).

# Komentar
# Ini tidak akan dieksekusi oleh sistem

# Contoh sederhana
echo "Halo, ini contoh Shell Script"

# Variabel
nama="Septian"
echo "Nama saya adalah $nama"

# Percabangan
if [ "$nama" = "Septian" ]; then
  echo "Halo, $nama!"
fi

# Perulangan
for i in {1..5}; do
  echo "Angka ke-$i"
done
```

---

## 4. Komponen Dasar Shell Script

| Komponen | Fungsi | Contoh |
|-----------|---------|---------|
| **Shebang (`#!/bin/bash`)** | Menentukan interpreter yang digunakan. | `#!/bin/bash` |
| **Komentar (`#`)** | Menambahkan catatan yang tidak dijalankan. | `# Ini komentar` |
| **Variabel** | Menyimpan nilai sementara. | `nama="Andi"` |
| **Input/Output** | Interaksi dengan pengguna. | `read nama`, `echo $nama` |
| **Percabangan (if)** | Mengecek kondisi dan menjalankan perintah sesuai hasilnya. | `if [ $x -gt 5 ]; then ... fi` |
| **Perulangan (for/while)** | Menjalankan perintah berulang. | `for i in {1..10}; do echo $i; done` |
| **Fungsi** | Mengelompokkan perintah agar bisa digunakan berulang kali. | `function tampil() { echo "Hai"; }` |

---

## 5. Cara Membuat dan Menjalankan Script

### Langkah 1: Buat file baru
```bash
nano script.sh
```

### Langkah 2: Tambahkan isi kode
Masukkan kode yang ingin dijalankan.

### Langkah 3: Simpan dan beri izin eksekusi
```bash
chmod +x script.sh
```

### Langkah 4: Jalankan script
```bash
./script.sh
```
atau
```bash
bash script.sh
```

---

## 6. Contoh Program Lengkap

### Program: Menampilkan dan menghitung jumlah nilai ganjil
```bash
#!/bin/bash

data=(3 6 7 8 9 11 4 9 5 2 2 4 6 6)
jumlah_ganjil=0

echo "Nilai ganjil:"

for angka in "${data[@]}"; do
  if (( angka % 2 != 0 )); then
    echo -n "$angka "
    (( jumlah_ganjil++ ))
  fi
done

echo
echo "Total jumlah nilai ganjil: $jumlah_ganjil"
```

**Output:**
```
Nilai ganjil:
3 7 9 11 9 5 
Total jumlah nilai ganjil: 6
```

---

## 7. Konsep Penting dalam Shell Script

1. **Komentar (#)**  
   Digunakan untuk memberi catatan agar script mudah dipahami.
   
2. **Variabel dan Ekspansi**  
   Gunakan `$` untuk mengambil nilai variabel.  
   Contoh: `echo "Nama: $nama"`

3. **Operator Aritmetika dan Logika**  
   Gunakan `(( ))` untuk perhitungan angka.  
   Gunakan `[ ]` untuk perbandingan logika.

4. **Looping dan Kondisi**  
   Mengontrol alur program dengan `for`, `while`, dan `if`.

5. **Fungsi (function)**  
   Mempermudah pengelompokan logika agar kode rapi dan reusable.

---

## 8. Kelebihan Shell Script

- Mudah dipelajari dan ditulis.
- Tidak butuh kompilasi.
- Sudah tersedia di hampir semua sistem Linux/Unix.
- Cocok untuk pekerjaan otomasi server dan DevOps.
- Dapat diintegrasikan dengan cron job untuk menjalankan otomatis.

---

## 9. Kekurangan Shell Script

- Kurang efisien untuk program besar atau kompleks.
- Tidak cocok untuk aplikasi dengan tampilan GUI.
- Sulit debug jika script panjang.
- Kurang portabel di sistem non-Unix (contoh Windows tanpa WSL).

---

## 10. Contoh Penggunaan Nyata

| Kategori | Contoh Penggunaan |
|-----------|-------------------|
| **Administrasi Sistem** | Backup file, pembersihan log, monitoring CPU |
| **DevOps** | Deployment otomatis, konfigurasi server |
| **Data Processing** | Menggabungkan file CSV, parsing log |
| **Automasi Harian** | Mengirim laporan otomatis, sinkronisasi folder |
| **Testing Sederhana** | Menjalankan tes unit secara berulang |

---

## 11. Tips Praktis

- Gunakan komentar untuk menjelaskan maksud kode.
- Gunakan nama variabel yang jelas.
- Simpan script penting di folder `/usr/local/bin` agar bisa dijalankan dari mana saja.
- Tambahkan log (`echo`) untuk memantau proses saat script berjalan.
- Gunakan `set -e` di awal script untuk menghentikan eksekusi jika ada error.

---

## 12. Rangkuman

- File `.sh` = kumpulan perintah otomatis untuk Shell.  
- Interpreter utama: **Bash (Bourne Again Shell)**.  
- Bisa menjalankan logika, perulangan, fungsi, dan operasi file.  
- Digunakan luas di bidang **DevOps**, **SysAdmin**, dan **Automation**.

---

## 13. Latihan Praktis Dasar

1. **Membuat Hello World**
   ```bash
   #!/bin/bash
   echo "Halo Dunia!"
   ```

2. **Menampilkan Waktu Sekarang**
   ```bash
   #!/bin/bash
   echo "Waktu saat ini: $(date)"
   ```

3. **Cek File Ada atau Tidak**
   ```bash
   #!/bin/bash
   if [ -f "data.txt" ]; then
     echo "File ditemukan"
   else
     echo "File tidak ada"
   fi
   ```

4. **Menjumlahkan Dua Angka**
   ```bash
   #!/bin/bash
   read -p "Masukkan angka pertama: " a
   read -p "Masukkan angka kedua: " b
   echo "Hasil penjumlahan: $((a + b))"
   ```

5. **Looping Sederhana**
   ```bash
   #!/bin/bash
   for i in {1..5}; do
     echo "Perulangan ke-$i"
   done
   ```

---

## 14. Referensi dan Bacaan Lanjutan

- [GNU Bash Manual](https://www.gnu.org/software/bash/manual/)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
- [Bash Cheatsheet by devhints.io](https://devhints.io/bash)
- [Shell Scripting Tutorial - GeeksforGeeks](https://www.geeksforgeeks.org/introduction-linux-shell-shell-scripting/)
