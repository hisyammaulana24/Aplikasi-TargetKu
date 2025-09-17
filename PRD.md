# Product Requirements Document (PRD): TargetKu
**Versi:** 1.0 (MVP)
**Tanggal:** 17 September 2025
**Penulis:** (Muhammad Hisyam Maulana) (Sahrul Firmanda Andreansyah)

---

## 1. Latar Belakang

### 1.1. Visi Produk
Menjadi aplikasi pencatat tabungan yang paling sederhana, ringan, dan memotivasi bagi pengguna di Indonesia untuk mencapai barang impian mereka.

### 1.2. Masalah yang Diselesaikan
Banyak orang, terutama kalangan muda, kesulitan untuk tetap konsisten dan termotivasi saat menabung untuk membeli suatu barang. Mereka sering kehilangan jejak progres, lupa berapa yang sudah terkumpul, dan tidak memiliki gambaran kapan target mereka akan tercapai. Aplikasi keuangan yang ada seringkali terlalu kompleks dengan fitur manajemen budget yang tidak dibutuhkan.

### 1.3. Solusi
**TargetKu** adalah aplikasi *single-purpose* yang berfokus sepenuhnya pada satu hal: membantu pengguna menabung untuk target tertentu. Dengan visualisasi progres yang jelas, kalkulasi estimasi pencapaian yang akurat berdasarkan rencana, dan antarmuka yang minimalis, TargetKu bertujuan untuk menjaga motivasi pengguna tetap tinggi hingga target mereka tercapai.

### 1.4. Target Audiens
*   Pelajar & Mahasiswa yang ingin menabung untuk membeli gadget, item hobi, atau tiket konser.
*   Pekerja muda (first-jobber) yang menabung untuk liburan, barang elektronik, atau DP kendaraan.
*   Siapa saja yang membutuhkan alat bantu sederhana untuk mencapai tujuan finansial jangka pendek.

---

## 2. Fitur Utama (MVP)

Fitur-fitur berikut akan diimplementasikan untuk rilis pertama (Minimum Viable Product).

### 2.1. Manajemen Target Tabungan
**User Story:** Sebagai pengguna, saya ingin dapat membuat satu atau lebih target tabungan untuk barang yang saya inginkan agar saya bisa melacak semuanya di satu tempat.

**Kriteria Penerimaan (Acceptance Criteria):**
- [ ] Pengguna dapat menekan tombol "Buat Target Baru".
- [ ] Pengguna harus mengisi form yang berisi:
    - Nama Target (Teks, Wajib).
    - Jumlah Target (Angka/Mata Uang, Wajib).
    - Gambar Target (Opsional, dari galeri atau kamera).
- [ ] Pengguna harus mendefinisikan **Rencana Menabung**:
    - **Frekuensi:** Pilihan antara Harian, Mingguan, Bulanan.
    - **Nominal Rencana:** Jumlah uang yang direncanakan untuk ditabung per periode.
- [ ] Setelah disimpan, target baru akan muncul di daftar "In Progress" pada halaman utama.
- [ ] Pengguna dapat mengedit dan menghapus target yang sudah ada.

### 2.2. Pencatatan Transaksi
**User Story:** Sebagai pengguna, saya ingin mencatat setiap kali saya menabung (atau terpaksa mengambil uang) untuk target saya agar data progres selalu akurat.

**Kriteria Penerimaan (Acceptance Criteria):**
- [ ] Dari halaman detail target, terdapat tombol aksi (Floating Action Button) untuk menambah transaksi.
- [ ] Saat menambah transaksi, pengguna bisa memilih jenisnya:
    - **Pemasukan (Increase):** Menambah saldo tabungan.
    - **Pengeluaran (Decrease):** Mengurangi saldo tabungan.
- [ ] Pengguna harus memasukkan **Nominal** transaksi.
- [ ] Pengguna dapat menambahkan **Deskripsi** (Opsional).
- [ ] Tanggal dan waktu transaksi tercatat otomatis tetapi bisa diubah.
- [ ] Setiap transaksi yang disimpan akan muncul di riwayat pada halaman detail target.

### 2.3. Visualisasi & Pelacakan Progres
**User Story:** Sebagai pengguna, saya ingin melihat progres tabungan saya secara visual dan mengetahui perkiraan kapan target saya akan tercapai agar saya tetap termotivasi.

**Kriteria Penerimaan (Acceptance Criteria):**
- [ ] **Halaman Utama:** Menampilkan daftar semua target dalam bentuk kartu.
    - Setiap kartu menampilkan: Nama Target, Gambar, Progress Bar, Persentase.
    - Terdapat tab untuk memfilter target: "In Progress" dan "Selesai" (Complete).
- [ ] **Halaman Detail:**
    - Menampilkan informasi lengkap: Total Terkumpul, Sisa, Tanggal Dibuat.
    - Menampilkan **Estimasi Pencapaian** yang dihitung berdasarkan **Rencana Menabung**.
        - Rumus: `Sisa Target / Nominal Rencana per Periode = Jumlah Periode Tersisa`.
    - Jika total tabungan sudah mencapai atau melebihi jumlah target, status target otomatis berubah menjadi "Selesai".

### 2.4. Pengingat Menabung
**User Story:** Sebagai pengguna, saya ingin mendapatkan notifikasi pengingat agar saya tidak lupa menabung sesuai dengan rencana yang telah saya buat.

**Kriteria Penerimaan (Acceptance Criteria):**
- [ ] Di halaman detail target, ada opsi untuk mengaktifkan/menonaktifkan pengingat.
- [ ] Jika diaktifkan, aplikasi akan mengirimkan notifikasi lokal (local notification) sesuai dengan frekuensi yang dipilih pada Rencana Menabung (Harian, Mingguan, atau Bulanan).
- [ ] Teks notifikasi bersifat memotivasi, contoh: "Saatnya nabung untuk iPad Pro kamu! Jangan menyerah!".

---

## 3. Alur Pengguna (User Flow)

1.  **Pengguna Baru:** Buka Aplikasi -> Halaman Sambutan (Onboarding) -> Halaman Utama (kosong) -> Klik "Buat Target" -> Isi Form Target -> Simpan -> Kembali ke Halaman Utama dengan 1 target.
2.  **Menambah Tabungan:** Buka Aplikasi -> Halaman Utama -> Pilih Target -> Halaman Detail -> Klik Tombol "+" -> Pilih "Pemasukan" -> Isi Nominal -> Simpan -> Progres di Halaman Detail & Utama ter-update.
3.  **Menyelesaikan Target:** Pengguna terus menambah tabungan hingga progres mencapai 100%. Target otomatis pindah dari tab "In Progress" ke "Selesai".

---

## 4. Persyaratan Non-Fungsional

- **Performa:** Aplikasi harus ringan, cepat dibuka (< 2 detik), dan responsif.
- **UI/UX:** Desain bersih, modern, dan intuitif. Alur harus sesederhana mungkin untuk menghindari kebingungan.
- **Persistensi Data:** Semua data target dan transaksi harus disimpan secara lokal di perangkat menggunakan database (Drift/SQLite). Data tidak boleh hilang jika aplikasi ditutup.
- **Platform:** Aplikasi dibuat untuk Android dan iOS menggunakan Flutter.
- **Arsitektur:** Mengimplementasikan prinsip Clean Architecture untuk memisahkan lapisan Domain, Data, dan Presentation.

---

## 5. Teknologi yang Digunakan

- **Framework:** Flutter
- **State Management:** Riverpod (dengan Riverpod Generator)
- **Model:** Freezed
- **Navigasi:** Go_Router
- **Database Lokal:** Drift (SQLite wrapper)
- **Error Handling:** fpdart (Either type)
- **Logging:** Logger

---

## 6. Di Luar Cakupan (Out of Scope for MVP)

Fitur-fitur berikut tidak akan dimasukkan dalam rilis pertama tetapi dapat dipertimbangkan untuk pengembangan di masa depan:

-   Sinkronisasi & Backup data ke Cloud (Google Drive/Firebase).
-   Mode Gelap (Dark Mode).
-   Kustomisasi Mata Uang & Bahasa.
-   Widget di Homescreen.
-   Fitur sosial atau berbagi progres.
-   Analitik & grafik pertumbuhan tabungan.

---