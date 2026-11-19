# Kasir Gudang

**Tema:** Manajemen Stok & Kasir Toko Kelontong / Sembako

Aplikasi ini dipilih untuk membantu pemilik toko kelontong atau grosir memantau stok barang antara gudang dan etalase secara rapi. Dengan pencatatan tugas restock dan rekap penjualan harian dalam satu aplikasi, proses operasional toko jadi lebih praktis dan meminimalkan risiko kehabisan stok.

## Tabel Pemetaan Model
| Kategori Data | Nama Model | Keterangan |
| :--- | :--- | :--- |
| **Data Utama** | `BarangToko` | Menyimpan daftar inventaris barang toko beserta harga beli, harga jual, dan jumlah stok gudang maupun etalase. |
| **Data Aksi** | `TugasStok` | Menyimpan daftar tugas restock atau pengecekan barang yang statusnya bisa dicentang selesai oleh pengguna. |
| **Data Informasi** | `RekapHarian` | Menampilkan ringkasan informasi transaksi dan rekap pendapatan penjualan harian toko. |

## Fitur Buatan Sendiri
*(Tulis 2–3 kalimat penjelasan fitur tambahan yang kamu bikin sendiri di project ini, misalnya fitur pencarian barang, filter kategori, atau perhitungan selisih stok otomatis)*

## Screenshot Aplikasi
### 1. Setiap Tab
- **Tab Beranda:** ![Beranda](<img width="1442" height="3202" alt="localhost_65514_(Samsung Galaxy S20 Ultra)" src="https://github.com/user-attachments/assets/bf989f3f-17ec-42b7-a854-453cec650d28" />
)
- **Tab Stok Barang:** ![Stok Barang](link_gambar_stok)
- **Tab Checklist Stok:** ![Checklist Stok](link_gambar_checklist)
- **Tab Kasir Rekap:** ![Kasir Rekap](link_gambar_rekap)

### 2. Beranda Sebelum & Sesudah Item Dicentang
- **Sebelum Dicentang:** ![Sebelum](link_gambar_sebelum)
- **Sesudah Dicentang:** ![Sesudah](link_gambar_sesudah)

## Hasil `flutter test`
![Hasil Flutter Test](link_gambar_test)
