<details>
<summary><b>Tugas 7</b></summary>

# Tugas 7: Elemen Dasar Flutter

## 1. Jelaskan apa itu *widget tree* pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
**Widget tree** adalah struktur hierarki yang menggambarkan hubungan antar widget dalam aplikasi Flutter.  
Setiap widget bisa memiliki satu atau lebih *child widget*, dan semuanya berawal dari satu *root widget*.  
Pada proyek ini, struktur sederhananya seperti berikut:

MyApp (parent)

└── MaterialApp

└── MyHomePage (Scaffold)

├── AppBar

└── Body (Column)

├── Row (berisi InfoCard)

└── GridView (berisi ItemCard)


Hubungan parent-child berarti widget induk mengatur posisi, tampilan, dan perilaku widget anak di dalamnya.  

---

## 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
| Widget | Fungsi |
|---------|--------|
| `MaterialApp` | Menjadi root aplikasi dan mengatur tema serta konfigurasi utama. |
| `Scaffold` | Menyediakan struktur dasar halaman seperti AppBar dan body. |
| `AppBar` | Menampilkan judul aplikasi di bagian atas. |
| `Column` | Menyusun widget secara vertikal. |
| `Row` | Menyusun widget secara horizontal. |
| `Card` | Menampilkan informasi dalam kotak dengan bayangan (untuk InfoCard). |
| `GridView.count` | Menyusun beberapa item dalam bentuk grid (untuk ItemCard). |
| `Icon` | Menampilkan ikon pada tombol. |
| `Text` | Menampilkan teks di setiap bagian aplikasi. |
| `SnackBar` | Menampilkan pesan singkat ketika tombol ditekan. |
| `Material` & `InkWell` | Memberikan efek sentuhan (ripple effect) pada kartu. |
| `Padding` & `SizedBox` | Mengatur jarak antar elemen agar tampilan rapi. |

---

## 3. Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
`MaterialApp` berfungsi sebagai *root widget* untuk aplikasi Flutter yang menggunakan gaya **Material Design**.  
Widget ini menyediakan tema global (`theme`), judul aplikasi (`title`), dan konfigurasi dasar lainnya.  
Pada proyek ini, `MaterialApp` digunakan karena aplikasi hanya memiliki satu halaman utama (`MyHomePage`) dan memakai tema biru sebagai warna utama.

---

## 4. Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`. Kapan kamu memilih salah satunya?
| Jenis Widget | Karakteristik | Contoh di Proyek |
|---------------|----------------|------------------|
| `StatelessWidget` | Tidak memiliki state yang berubah. Digunakan untuk tampilan statis. | `MyApp`, `MyHomePage`, `InfoCard`, `ItemCard` |
| `StatefulWidget` | Memiliki state yang bisa berubah selama aplikasi berjalan. | Tidak digunakan di proyek ini. |

Pada proyek ini, semua data bersifat statis (tidak berubah saat runtime), sehingga semua halaman menggunakan `StatelessWidget`.

---

## 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di metode `build`?
`BuildContext` adalah objek yang merepresentasikan posisi suatu widget di dalam *widget tree*.  
Objek ini penting karena digunakan untuk mengakses elemen-elemen yang lebih tinggi di tree, seperti:

- **Tema aplikasi:** `Theme.of(context).colorScheme.primary`
- **SnackBar:** `ScaffoldMessenger.of(context).showSnackBar(...)`

Di proyek ini, `BuildContext` digunakan di dalam `build()` untuk mengambil warna tema dan menampilkan SnackBar saat tombol ditekan.

---

## 6. Jelaskan konsep *hot reload* di Flutter dan bagaimana bedanya dengan *hot restart*.
| Konsep | Penjelasan | Dampaknya |
|---------|-------------|-----------|
| **Hot Reload** | Menyisipkan perubahan kode ke aplikasi yang sedang berjalan tanpa menghapus state. | Cepat; cocok untuk ubah UI. |
| **Hot Restart** | Menjalankan ulang seluruh aplikasi dan menginisialisasi semua state dari awal. | Lebih lambat; cocok untuk ubah variabel global atau struktur besar. |

Pada proyek ini, kamu dapat menggunakan **hot reload** saat mengubah warna tombol atau teks tanpa kehilangan halaman yang sedang terbuka.

---

</details>

<details>
<summary><b>Tugas 8</b></summary>

# Tugas 8: Navigasi dan Layout di Flutter

## 1. Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
- **`Navigator.push()`** menambahkan halaman baru di atas stack navigasi yang sudah ada.  
  Artinya, halaman sebelumnya masih tersimpan di memori dan pengguna bisa kembali ke sana dengan tombol **Back**.  
  Contoh pada proyek: ketika pengguna membuka halaman **Create Product**, halaman utama masih dapat diakses kembali dengan tombol back.

- **`Navigator.pushReplacement()`** menggantikan halaman saat ini dengan halaman baru.  
  Halaman sebelumnya dihapus dari stack, sehingga pengguna **tidak dapat kembali** ke halaman sebelumnya.  
  Cocok digunakan untuk navigasi yang bersifat final seperti berpindah dari halaman **login** ke **beranda utama**.

---

## 2. Bagaimana kamu memanfaatkan *hierarchy widget* seperti `Scaffold`, `AppBar`, dan `Drawer` untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
Pada aplikasi Football Shop:
- `Scaffold` digunakan sebagai struktur dasar setiap halaman, menyediakan area untuk `AppBar`, `Drawer`, dan `body`.
- `AppBar` menampilkan judul “Toko Football” di bagian atas setiap halaman agar tampil konsisten.
- `Drawer` berfungsi sebagai navigasi samping (sidebar) yang memudahkan pengguna berpindah antar halaman tanpa kehilangan konteks.
- Kombinasi ketiganya membentuk kerangka halaman yang seragam dan mudah dikembangkan.

---

## 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan *layout widget* seperti `Padding`, `SingleChildScrollView`, dan `ListView` saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
| Widget | Kelebihan | Contoh Penggunaan |
|---------|------------|------------------|
| `Padding` | Memberi jarak di sekitar widget agar elemen tidak menempel satu sama lain. | Digunakan pada form input agar teks dan tombol terlihat rapi. |
| `SingleChildScrollView` | Membuat seluruh halaman bisa di-*scroll*, mencegah elemen tertutup keyboard di layar kecil. | Digunakan di halaman **Create Product** agar form bisa di-scroll. |
| `ListView` | Menampilkan daftar elemen yang banyak secara efisien (bisa di-scroll otomatis). | Dapat digunakan untuk menampilkan daftar produk di halaman **All Products**. |

Dengan kombinasi ketiga layout widget ini, tampilan form tetap responsif dan nyaman di berbagai ukuran layar.

---

## 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Aplikasi Football Shop menggunakan tema warna utama biru (`primaryColor`) yang diatur melalui `ThemeData` pada `MaterialApp`.  
Selain itu, tombol-tombol di halaman utama diberi warna berbeda sesuai fungsinya agar tetap menarik namun konsisten:
- **All Products:** Biru (warna utama brand)
- **My Products:** Hijau (melambangkan manajemen data pribadi)
- **Create Product:** Merah (menunjukkan aksi penting/tambah produk)

Penggunaan warna-warna ini membantu menjaga identitas visual aplikasi sekaligus memperkuat pengalaman pengguna (UX) dengan kode warna yang intuitif.

---

</details>
