# Software Requirements Specification (SRS): TargetKu
**Versi:** 1.0 (MVP)
**Tanggal:** 17 September 2025
**Status:** Draf

---

## Daftar Isi
1.  [Pendahuluan](#1-pendahuluan)
    1.1. [Tujuan](#11-tujuan)
    1.2. [Ruang Lingkup](#12-ruang-lingkup)
    1.3. [Definisi, Akronim, dan Singkatan](#13-definisi-akronim-dan-singkatan)
    1.4. [Referensi](#14-referensi)
2.  [Deskripsi Umum](#2-deskripsi-umum)
    2.1. [Perspektif Produk](#21-perspektif-produk)
    2.2. [Fungsi Produk](#22-fungsi-produk)
    2.3. [Karakteristik Pengguna](#23-karakteristik-pengguna)
    2.4. [Batasan (Constraints)](#24-batasan-constraints)
    2.5. [Asumsi dan Ketergantungan](#25-asumsi-dan-ketergantungan)
3.  [Persyaratan Spesifik](#3-persyaratan-spesifik)
    3.1. [Persyaratan Fungsional](#31-persyaratan-fungsional)
    3.2. [Persyaratan Non-Fungsional](#32-persyaratan-non-fungsional)
    3.3. [Persyaratan Antarmuka (Interface)](#33-persyaratan-antarmuka-interface)

---

## 1. Pendahuluan

### 1.1. Tujuan
Dokumen ini bertujuan untuk mendefinisikan secara lengkap persyaratan fungsional dan non-fungsional untuk rilis pertama (MVP) dari aplikasi mobile **TargetKu**. Dokumen ini akan menjadi dasar untuk proses desain, pengembangan, dan pengujian aplikasi.

### 1.2. Ruang Lingkup
Produk yang akan dikembangkan adalah aplikasi mobile untuk platform Android dan iOS yang berfungsi sebagai alat pencatat tabungan berbasis tujuan. Pengguna dapat membuat target tabungan, mencatat transaksi, dan memantau progres serta estimasi waktu pencapaian.

**Fitur di luar ruang lingkup (Out of Scope) untuk versi 1.0:**
- Sinkronisasi data antar perangkat (Cloud Backup).
- Mode Gelap (Dark Mode).
- Dukungan multi-mata uang atau multi-bahasa.
- Widget Homescreen.
- Fitur sosial dan analitik.

### 1.3. Definisi, Akronim, dan Singkatan
- **Target:** Tujuan tabungan yang dibuat oleh pengguna.
- **Transaksi:** Catatan pemasukan (`increase`) atau pengeluaran (`decrease`) dana.
- **Rencana Menabung:** Komitmen pengguna untuk menabung sejumlah nominal dalam frekuensi tertentu.
- **MVP:** Minimum Viable Product, versi produk dengan fitur paling esensial.
- **UI:** User Interface (Antarmuka Pengguna).
- **UX:** User Experience (Pengalaman Pengguna).
- **SRS:** Software Requirements Specification.
- **PRD:** Product Requirements Document.

### 1.4. Referensi
- Product Requirements Document (PRD): TargetKu v1.0
- Skema Database: TargetKu v1.0

---

## 2. Deskripsi Umum

### 2.1. Perspektif Produk
TargetKu adalah produk yang berdiri sendiri (*self-contained*). Untuk versi MVP, aplikasi tidak memerlukan koneksi internet untuk fungsi utamanya dan tidak berinteraksi dengan sistem eksternal lainnya. Semua data disimpan secara lokal di perangkat pengguna.

### 2.2. Fungsi Produk
Fungsi utama dari TargetKu adalah:
1.  **Manajemen Target:** Membuat, melihat, mengedit, dan menghapus target tabungan.
2.  **Manajemen Transaksi:** Mencatat pemasukan dan pengeluaran dana untuk setiap target.
3.  **Pelacakan Progres:** Menghitung dan menampilkan progres tabungan secara visual.
4.  **Kalkulasi Estimasi:** Memberikan perkiraan waktu pencapaian target berdasarkan rencana menabung.
5.  **Pengingat:** Memberikan notifikasi untuk membantu pengguna konsisten menabung.

### 2.3. Karakteristik Pengguna
Pengguna TargetKu adalah individu yang melek teknologi namun membutuhkan alat yang sederhana dan tidak rumit. Mereka termotivasi oleh visual dan tujuan yang jelas. Mereka tidak memerlukan fitur akuntansi atau manajemen keuangan yang kompleks.

### 2.4. Batasan (Constraints)
- **C-1:** Aplikasi harus dikembangkan menggunakan framework Flutter.
- **C-2:** State management harus menggunakan Riverpod.
- **C-3:** Penyimpanan data lokal harus menggunakan database SQLite yang dikelola oleh library Drift.
- **C-4:** Aplikasi harus mendukung sistem operasi Android (versi TBD) dan iOS (versi TBD).
- **C-5:** Semua data pengguna harus disimpan secara lokal di perangkat. Tidak ada data finansial yang ditransmisikan melalui jaringan.

### 2.5. Asumsi dan Ketergantungan
- **A-1:** Pengguna memiliki perangkat smartphone yang kompatibel dengan aplikasi.
- **A-2:** Pengguna memberikan izin kepada aplikasi untuk mengirimkan notifikasi agar fitur pengingat dapat berfungsi.

---

## 3. Persyaratan Spesifik

### 3.1. Persyaratan Fungsional

#### 3.1.1. Manajemen Target (FR-TGT)
- **FR-TGT-001:** Sistem **harus** menyediakan fungsionalitas untuk membuat target baru dengan input berikut:
    - Nama Target (Teks, Wajib)
    - Jumlah Target (Numerik, Wajib)
    - Gambar Target (Gambar, Opsional)
    - Nominal Rencana (Numerik, Wajib)
    - Frekuensi Rencana (Pilihan: Harian/Mingguan/Bulanan, Wajib)
- **FR-TGT-002:** Sistem **harus** menampilkan daftar target yang ada pada halaman utama.
- **FR-TGT-003:** Sistem **harus** menyediakan filter untuk memisahkan target dengan status "In Progress" dan "Selesai".
- **FR-TGT-004:** Sistem **harus** menampilkan halaman detail untuk setiap target, yang berisi semua informasi target dan riwayat transaksinya.
- **FR-TGT-005:** Sistem **harus** mengizinkan pengguna untuk mengedit informasi target yang ada.
- **FR-TGT-006:** Sistem **harus** mengizinkan pengguna untuk menghapus target beserta semua transaksi yang terkait.
- **FR-TGT-007:** Sistem **harus** secara otomatis mengubah status target menjadi "Selesai" ketika total dana terkumpul mencapai atau melebihi Jumlah Target.

#### 3.1.2. Manajemen Transaksi (FR-TRX)
- **FR-TRX-001:** Sistem **harus** mengizinkan pengguna untuk menambahkan transaksi `Pemasukan` (Increase) dengan input:
    - Nominal (Numerik, Wajib)
    - Deskripsi (Teks, Opsional)
    - Tanggal (Tanggal, Default hari ini)
- **FR-TRX-002:** Sistem **harus** mengizinkan pengguna untuk menambahkan transaksi `Pengeluaran` (Decrease) dengan input yang sama seperti FR-TRX-001.
- **FR-TRX-003:** Sistem **harus** menampilkan riwayat transaksi pada halaman detail target, diurutkan dari yang terbaru ke terlama.

#### 3.1.3. Kalkulasi & Visualisasi (FR-CAL)
- **FR-CAL-001:** Sistem **harus** menghitung total dana terkumpul dengan formula: `(Total Pemasukan) - (Total Pengeluaran)`.
- **FR-CAL-002:** Sistem **harus** menghitung dan menampilkan progres dalam bentuk persentase dengan formula: `(Total Dana Terkumpul / Jumlah Target) * 100`.
- **FR-CAL-003:** Sistem **harus** menghitung dan menampilkan estimasi waktu pencapaian dengan formula: `(Jumlah Target - Total Dana Terkumpul) / Nominal Rencana`.
- **FR-CAL-004:** Sistem **harus** menampilkan progres dalam bentuk progress bar yang visual.

#### 3.1.4. Notifikasi Pengingat (FR-NOT)
- **FR-NOT-001:** Sistem **harus** menyediakan opsi untuk mengaktifkan atau menonaktifkan pengingat untuk setiap target.
- **FR-NOT-002:** Jika aktif, sistem **harus** menjadwalkan notifikasi lokal sesuai dengan Frekuensi Rencana yang telah ditetapkan (harian, mingguan, atau bulanan).

### 3.2. Persyaratan Non-Fungsional

#### 3.2.1. Kinerja (NFR-PERF)
- **NFR-PERF-001:** Waktu startup aplikasi (cold start) harus kurang dari 2 detik.
- **NFR-PERF-002:** Transisi antar layar dan animasi harus berjalan mulus (60 FPS) tanpa lag atau jank pada perangkat target.
- **NFR-PERF-003:** Operasi database (menyimpan/mengambil data) tidak boleh memblokir UI thread.

#### 3.2.2. Keandalan (NFR-REL)
- **NFR-REL-001:** Data pengguna (target dan transaksi) harus tersimpan secara persisten dan tidak boleh hilang saat aplikasi ditutup atau perangkat di-restart.
- **NFR-REL-002:** Tingkat *crash-free users* ditargetkan di atas 99.5%.

#### 3.2.3. Kemudahan Penggunaan (NFR-USA)
- **NFR-USA-001:** Alur untuk tugas utama (membuat target, menambah transaksi) harus intuitif dan dapat diselesaikan dalam langkah minimal (misal, < 3 klik untuk menambah transaksi dari home).
- **NFR-USA-002:** Aplikasi harus memberikan feedback visual yang jelas untuk setiap aksi pengguna (cth: loading indicator, pesan sukses).

#### 3.2.4. Keamanan (NFR-SEC)
- **NFR-SEC-001:** Semua data aplikasi harus disimpan dalam penyimpanan internal aplikasi yang terisolasi (*sandboxed*) dan tidak dapat diakses oleh aplikasi lain.

### 3.3. Persyaratan Antarmuka (Interface)

- **UI-001:** Antarmuka pengguna harus mengadopsi prinsip desain yang konsisten (misal: Material Design 3).
- **UI-002:** Aplikasi harus memiliki layout yang responsif dan dapat beradaptasi dengan berbagai ukuran layar ponsel.
- **UI-003:** Semua teks dalam aplikasi harus menggunakan Bahasa Indonesia.

---