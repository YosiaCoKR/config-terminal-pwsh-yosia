# 🚀 Yosiasp Terminal Configuration

Repositori ini berisi konfigurasi lengkap untuk Windows Terminal dan PowerShell yang dirancang untuk produktivitas maksimal, tampilan yang bersih, dan integrasi Git yang kuat.

## 🌟 Fitur Utama

- **Tampilan Menawan:** Menggunakan skema warna **SynthWave 84** dengan transparansi (opacity 65%) dan padding yang nyaman.
- **Prompt Cerdas:** Ditenagai oleh **Oh My Posh** (menggunakan tema `easy-term.omp.json`).
- **Font:** Menggunakan **FiraCode Nerd Font Mono** untuk dukungan ikon yang kaya.
- **Navigasi Cepat:** Integrasi dengan **zoxide** untuk perpindahan direktori yang instan.
- **History Pintar:** Menggunakan **atuin** dan fitur prediksi **PSReadLine** dengan tampilan _ListView_.
- **Ikon & Warna:** Menggunakan `eza` (pengganti `ls`) dan `bat` (pengganti `cat`), serta ikon direktori via `Terminal-Icons`.
- **Git Power-Pack:** Puluhan alias Git untuk mempercepat _workflow_.

## 🛠️ Persyaratan (Prerequisites)

Untuk mendapatkan pengalaman maksimal, pastikan Anda telah menginstal _tools_ berikut:

1. [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701)
2. [PowerShell (pwsh)](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows)
3. [Nerd Fonts](https://www.nerdfonts.com/) (Rekomendasi: **FiraCode Nerd Font**)
4. [Oh My Posh](https://ohmyposh.dev/)
5. Modul PowerShell:
   ```powershell
   Install-Module -Name Terminal-Icons -Repository PSGallery
   Install-Module -Name posh-git -Repository PSGallery
   ```
6. CLI Tools pendukung (Bisa diinstal via `winget` atau `scoop`):
   - `eza` (Modern replacement for ls)
   - `bat` (Cat clone with syntax highlighting)
   - `zoxide` (Smarter cd command)
   - `atuin` (Magical shell history)
   - `fzf` (Command-line fuzzy finder)
   - `peco` (Simplistic interactive filtering tool)
   - `gsudo` (Sudo for Windows)
   - `fastfetch` (System information tool)

## 📁 Struktur Direktori

- `Microsoft.PowerShell_profile.ps1` : File konfigurasi utama PowerShell (Profile).
- `json-setting-for-terminal.json` : Pengaturan UI/UX dan konfigurasi untuk Windows Terminal.
- `*.omp.json` : Berbagai pilihan tema untuk Oh My Posh:
  - `easy-term.omp.json` _(Default)_
  - `clean-detailed.omp.json`
  - `cloud-native-azure.omp.json`
  - `if_tea.omp.json`

## ⌨️ Daftar Alias & Perintah Kustom

### Alias Umum

| Perintah | Deskripsi                                                   |
| -------- | ----------------------------------------------------------- |
| `sudo`   | Menjalankan `gsudo`                                         |
| `ls`     | Menjalankan `eza --icons --group-directories-first`         |
| `ll`     | Menjalankan `eza -l --icons --group-directories-first`      |
| `cat`    | Menjalankan `bat --paging=never`                            |
| `f`      | Mencari file dengan `fzf` dan preview isi file dengan `bat` |

### Git Power-Pack

| Alias                     | Perintah Asli                           | Deskripsi                                              |
| ------------------------- | --------------------------------------- | ------------------------------------------------------ |
| `ga`                      | `git add .`                             | Menambahkan semua perubahan                            |
| `gs`                      | `git status`                            | Melihat status repository                              |
| `gc "Pesan"`              | `git commit -m "Pesan"`                 | Melakukan commit                                       |
| `gp`                      | `git push`                              | Mendorong perubahan ke remote                          |
| `gl`                      | `git pull`                              | Menarik perubahan dari remote                          |
| `gb`                      | `git branch`                            | Melihat daftar branch                                  |
| `gco <branch>`            | `git checkout <branch>`                 | Berpindah branch                                       |
| `gnb <branch>`            | `git checkout -b <branch>`              | Membuat branch baru dan berpindah                      |
| `gsh`                     | `git stash`                             | Menyimpan perubahan sementara (stash)                  |
| `gsp`                     | `git stash pop`                         | Mengambil dan menerapkan stash terakhir                |
| `gsl`                     | `git stash list`                        | Melihat daftar stash                                   |
| `gd`                      | `git diff`                              | Melihat perbedaan file yang belum di-stage             |
| `gds`                     | `git diff --staged`                     | Melihat perbedaan file yang sudah di-stage             |
| `glog`                    | `git log --oneline --graph --all`       | Melihat log git dalam bentuk grafis rapi               |
| `grv`                     | `git remote -v`                         | Melihat daftar remote URL                              |
| `grs <file>`              | `git restore --staged <file>`           | Membatalkan file dari staged area                      |
| `grh`                     | `git reset --hard HEAD`                 | Reset keras ke commit terakhir (buang semua perubahan) |
| `guc`                     | `git reset --soft HEAD~1`               | Membatalkan commit terakhir (perubahan tetap ada)      |
| `gacp "Pesan"`            | `git add . ; git commit ... ; git push` | Add, Commit, dan Push sekaligus                        |
| `gpu`                     | `git push -u origin HEAD`               | Push branch saat ini & set upstream ke origin          |
| `gpo`                     | `git pull origin <branch>`              | Pull perubahan terbaru dari origin untuk branch aktif  |
| `gwhere`                  | `git rev-parse ...; git status -sb`     | Menampilkan info nama branch dan status ringkas        |
| `gsom`                    | `git checkout main; git pull`           | Pindah ke branch main dan pull pembaruan terakhir      |
| `gnbm <branch>`           | `gsom; git checkout -b <branch>`        | Update main dan langsung buat branch baru dari sana    |
| `gmain`                   | (Interaktif)                            | Pindah ke main, pull, dan merge dari branch sebelumnya |
| `gclean`                  | `git branch -d ...`                     | Menghapus semua branch lokal yang sudah di-merge       |
| `gbr`                     | `git branch -v` & `-rv`                 | Melihat informasi detail branch lokal dan remote       |

### Troubleshooting & Utility

| Perintah   | Deskripsi                                                                         |
| ---------- | --------------------------------------------------------------------------------- |
| `kport`    | Menampilkan proses yang mendengarkan port tertentu (via `peco`) dan mematikannya. |
| `kill-pro` | Menampilkan daftar proses (via `peco`) dan mematikannya berdasarkan nama.         |
| `gold`     | Mengecek harga emas terkini via `rate.sx`.                                        |
| `cuaca`    | Mengecek cuaca di Jakarta via `wttr.in`.                                          |
| `copy`     | Menyalin _output_ sebelumnya ke clipboard Windows (`clip`).                       |
| `clean-py` | Menghapus semua folder `__pycache__` di direktori saat ini secara rekursif.       |

## 🚀 Cara Instalasi

1. **Konfigurasi PowerShell Profile:**
   - Buka PowerShell dan ketik `notepad $PROFILE`.
   - Salin seluruh isi dari file `Microsoft.PowerShell_profile.ps1` ke dalam file profile Anda, lalu simpan.
   - Pastikan path ke config oh-my-posh disesuaikan dengan lokasi Anda meletakkan file `.omp.json`.

2. **Konfigurasi Windows Terminal:**
   - Buka Windows Terminal > Settings > Open JSON file (ikon gir kecil di kiri bawah atau `Ctrl+Shift+,`).
   - Salin dan gabungkan pengaturan dari `json-setting-for-terminal.json` ke file pengaturan Windows Terminal Anda (khususnya bagian `schemes`, `profiles.defaults`, dan `actions`).

3. Restart Windows Terminal Anda dan nikmati pengalaman terminal yang luar biasa!
