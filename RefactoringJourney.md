# Scentcy Refactoring Journey

Berikut adalah dokumentasi 10 tahap *refactor* utama yang telah direncanakan dan dieksekusi pada *codebase* aplikasi Scentcy:

1. 🔴 **Refactor 1: Typography & Dynamic Type Support (P0)**
   * Mengganti `.font(.system(size:))` dengan `Font.system(.textStyle)` agar teks bisa beradaptasi dengan ukuran yang diatur pengguna di pengaturan iOS (Dynamic Type) sesuai standar HIG.
2. 🔴 **Refactor 2: Dark Mode Support (P0)** 
   * Mengimplementasikan skema warna yang adaptif antara mode Terang (Light Mode) dan Gelap (Dark Mode), mengganti warna absolut (seperti `Color.white` atau hex statis) dengan warna adaptif.
3. 🔴 **Refactor 3: MVVM Architecture Violations (P0)**
   * Memisahkan logika bisnis dan SwiftData dari *View* menuju `ViewModel` (pembuatan `CameraViewModel`, `HomeViewModel`, dan `PerfumeDetailViewModel`).
4. 🔴 **Refactor 4: Force Unwraps & Error Handling (P0)**
   * Menghapus penggunaan `!` (*force unwrap*) yang berisiko membuat aplikasi *crash* (di `PerfumeClassifier` dan `DataManager`) dan menggantinya dengan penanganan *error* yang aman.
5. 🟠 **Refactor 5: Dependency Injection & Testability (P1)**
   * Membuat *protocol* (`DataManaging`, `RecommendationServicing`, `CameraServicing`) agar komponen tidak saling terikat erat (*tightly coupled*) dan lebih mudah di-*test*.
6. 🟠 **Refactor 6: Hardcoded Values → Design System (P1)**
   * Memperluas `Constants.swift` dan membersihkan angka-angka statis (*magic numbers*) seperti `padding(16)` atau `cornerRadius(24)` dari puluhan file UI agar seragam.
7. 🟠 **Refactor 7: Reusable Components & Deduplication (P1)**
   * Menggabungkan komponen UI yang mirip untuk mengurangi duplikasi kode (seperti berbagai jenis *chip* menjadi `ChipView`, layar kosong menjadi `EmptyStateView`), serta menghapus *dead code*.
8. 🟠 **Refactor 8: Accessibility (P1)**
   * Menambahkan dukungan *VoiceOver* dengan modifier `.accessibilityLabel`, `.accessibilityElement(children: .combine)`, dan `.accessibilityHidden(true)`.
9. 🟡 **Refactor 9: Code Quality & Conventions (P2)**
   * Merapikan konvensi penamaan standar Swift, mengubah `scentcyApp` menjadi `ScentcyApp`, `Perfumecard` menjadi `PerfumeCard`, dan mengeliminasi nama *method* dengan awalan `get`.
10. 🟡 **Refactor 10: App Architecture & Navigation (P2)**
    * Memperbarui *navigation* menjadi standar `.navigationTitle()`, menggunakan `Task` untuk *concurrency*, mengimplementasikan logika *skip* Onboarding (`@AppStorage`), dan memindahkan *seed data* dari array *hardcoded* menjadi `perfumes.json`.
