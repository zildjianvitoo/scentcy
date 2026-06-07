# Scentcy iOS App

Scentcy adalah aplikasi rekomendasi parfum berbasis iOS yang dikembangkan dengan SwiftUI dan menggunakan arsitektur MVVM dengan pendekatan **Feature-Based Modular Architecture**.

---

## 🏗 Struktur Folder (Architecture)

Proyek ini menggunakan pemisahan folder berdasarkan **Fitur** (Feature-Based) untuk memastikan kodenya terstruktur, dapat di-scale dengan baik, dan meminimalisir konflik saat dikerjakan oleh banyak orang (kolaborasi tim).

```text
scentcy/
│
├── Core/                   # Berisi semua hal yang bisa digunakan kembali (reusable) di seluruh aplikasi
│   ├── Common/             # Komponen UI global (contoh: PrimaryButton, CameraFloatingButton, FlowLayout)
│   ├── Entities/           # Model data global atau response API yang dipakai lintas fitur
│   ├── Extension/          # Extension bawaan Swift/SwiftUI (Color+Extension, Typography+Extension)
│   ├── Managers/           # Global Managers (contoh: HapticManager, UserSessionManager)
│   └── Utils/              # Konstanta, Helper, dan utilitas pendukung (Constants.swift)
│
├── Features/               # Folder utama pengembangan. Setiap modul fitur memiliki foldernya sendiri.
│   ├── Camera/
│   │   ├── Models/         # Data spesifik untuk fitur Camera
│   │   ├── Services/       # Logika komunikasi API / Backend / Hardware Camera
│   │   ├── ViewModels/     # Business logic untuk CameraView
│   │   └── Views/          # SwiftUI views (termasuk folder SupportViews untuk UI kecil-kecil)
│   │
│   ├── Main/               # Fitur utama seperti Tab Bar & Content View
│   ├── Onboarding/         # Fitur perkenalan awal aplikasi
│   ├── PerfumeDetails/     # Fitur rincian dari satu parfum
│   └── PerfumeRecommendation/ # Fitur rekomendasi parfum & Filter
│
└── Resources/              # Asset global (Assets.xcassets) dan konfigurasi statis lainnya
```

---

## ✍️ Aturan Penulisan Kode (Coding Guidelines)

Untuk menjaga *codebase* tetap bersih dan seragam, perhatikan aturan-aturan wajib berikut:

### 1. Typography & Font
Dilarang menggunakan *font hardcoded* seperti `.font(.system(size: 24, weight: .bold))` atau `.font(.headline)` pada teks biasa. **Gunakan selalu `Typography` enum.**
- ✅ Benar: `.font(Typography.bodyStrong)`
- ❌ Salah: `.font(.headline)`
*(Kecuali untuk icon atau simbol SF Symbols di mana `.system(size:)` terkadang wajib untuk akurasi dimensi vector)*

### 2. Warna (Color)
Dilarang menggunakan *magic colors* atau *hex hardcoded*. Gunakan selalu *Color Extension* yang sudah disepakati.
- ✅ Benar: `.foregroundColor(Color.appPrimary)`, `.background(Color.appGray)`
- ❌ Salah: `.foregroundColor(Color(hex: "F0D9BA"))`, `.background(Color(.systemGray5))`
*(Catatan: `.black`, `.white`, dan `.clear` bawaan SwiftUI masih diperbolehkan jika belum ada warna semantiknya)*

### 3. Spasi & Lengkungan (Constants UI)
Untuk padding standar dan *corner radius*, selalu merujuk ke file `Constants.swift`.
- ✅ Benar: `.padding(Constants.UI.defaultPadding)`, `.cornerRadius(Constants.UI.cornerRadius)`
- ❌ Salah: `.padding(16)`, `.cornerRadius(24)`

### 4. Komponen UI Reusable
Jangan membuat komponen berulang-ulang dari nol jika sudah ada di folder `Core/Common/Views`.
Contoh: Saat membuat tombol navigasi atau tombol submit utama, selalu gunakan komponen `PrimaryButton`. Jika komponen spesifik terlalu besar atau rumit di satu *file view*, pisahkan ke dalam folder `SupportViews` di dalam *feature* kamu agar struktur kode utama tetap mudah dibaca.

---

## 🌿 Git Workflow & Branching Rules

Pengerjaan proyek ini wajib menggunakan *Git Flow* yang disiplin. Sangat **DILARANG** melakukan komit apalagi *push* langsung ke *branch* utama (`main`).

### 1. Penamaan Branch
Format penamaan branch harus mendeskripsikan tipe perubahan yang dilakukan. Gunakan salah satu *prefix* berikut:
- `feature/nama-fitur` -> Untuk menambahkan fitur baru (contoh: `feature/onboarding-ui`)
- `bugfix/nama-bug` -> Untuk perbaikan error/bug (contoh: `bugfix/camera-crash`)
- `view/nama-view` -> Untuk pembuatan halaman UI khusus (contoh: `view/perfume-recom`)
- `refactor/nama-refactor` -> Untuk merapikan *code* tanpa mengubah fungsi (contoh: `refactor/typography`)

### 2. Aturan Commit Message
Gunakan *Conventional Commits* untuk memperjelas *history* agar mudah dilacak:
- `feat: menambahkan login screen`
- `fix: mengatasi crash saat kamera ditutup`
- `style: mengganti padding hardcoded dengan Constants`
- `refactor: memisahkan logic dari view ke viewModel`

### 3. Pull Request (PR) & Merging
1. **Push Branch Kamu**: Setelah *commit*, *push branch* kamu ke *remote repository*.
2. **Buat Pull Request (PR)**: Buka GitHub, lalu buat PR dari *branch* kamu menuju `main`.
3. **Deskripsi PR**: Tulis penjelasan singkat apa yang kamu kerjakan, letakkan *screenshot* jika ada perubahan UI.
4. **Code Review**: Wajib mendapatkan setidaknya 1 *approval* dari **Tech Lead**. Hal ini berguna untuk menghindari *bug* yang terlewat dan memastikan *guidelines* di atas diikuti dengan baik.
5. **Merge**: Jika sudah di-*approve* dan tidak ada konflik (Merge Conflict), *merge* branch tersebut (disarankan pakai metode *Squash and Merge* agar *commit history* utama tetap bersih). **Catatan: Hanya Tech Lead yang diizinkan untuk melakukan Merge ke main.**
6. **Cleanup**: Hapus *branch* yang sudah di-*merge* agar *repository* tidak penuh sampah *branch* lama. **Ini juga merupakan tugas Tech Lead setelah melakukan merge.**
