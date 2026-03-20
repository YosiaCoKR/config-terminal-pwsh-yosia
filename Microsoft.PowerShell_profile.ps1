# --- 1. TAMPILAN & WINDOW ---
$host.ui.RawUI.WindowTitle = "Yosiasp Terminal 🚀"
clear -x

# --- 2. INITIALIZATION (Theme & Tools) ---
# Jika oh-my-posh adalah modul, kita panggil lewat fungsinya
if (Get-Module -ListAvailable oh-my-posh) {
    # Gunakan perintah bawaan modul jika ada
    Set-PoshPrompt -Theme "$env:POSH_THEMES_PATH\clean-detailed.omp.json"
} elseif (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\clean-detailed.omp.json" | Out-String | Invoke-Expression
}

# Zoxide (Pintu Kemana Saja)
if (Get-Command zoxide -ErrorAction SilentlyContinue) { 
    zoxide init powershell --hook pwd | Out-String | Invoke-Expression 
}

# Atuin (History Pintar)
if (Get-Command atuin -ErrorAction SilentlyContinue) { 
    atuin init powershell | Out-String | Invoke-Expression 
}

# --- 3. MODUL ---
Import-Module -Name Terminal-Icons -ErrorAction SilentlyContinue
Import-Module -Name posh-git -ErrorAction SilentlyContinue
Import-Module PSReadLine

# --- 4. PREDIKSI (PSReadLine) ---
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key 'Ctrl+r' -Function HistorySearchBackward

# --- 5. ALIAS & SHORTCUTS ---
New-Alias sudo gsudo -ErrorAction SilentlyContinue
function ll { eza -l --icons --group-directories-first $args }
function ls { eza --icons --group-directories-first $args }

# Alias pendek untuk alat baru
if (Get-Command btm -ErrorAction SilentlyContinue) { Set-Alias -Name top -Value btm }
if (Get-Command dust -ErrorAction SilentlyContinue) { Set-Alias -Name du -Value dust }
if (Get-Command tldr -ErrorAction SilentlyContinue) { Set-Alias -Name t -Value tldr }
if (Get-Command jless -ErrorAction SilentlyContinue) { Set-Alias -Name json -Value jless }

# --- 6. FUNCTIONS (Senjata Sakti Yosia) ---

# Cek Harga Gold (XAUUSD)
function gold { curl -s rate.sx/XAU | Select-Object -First 15 }

# Cek Cuaca Jakarta
function cuaca { curl -s wttr.in/Jakarta?0pq }

# Copy to Clipboard
function copy { $input | clip }

# Clean Python Cache
function clean-py { Get-ChildItem -Recurse -Filter "__pycache__" | Remove-Item -Recurse -Force }

# Cari File (FZF) - Ketik 'f'
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    function f { fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" }
}

# Kill Process (Peco) - Versi Fix (Hanya ambil ID)
if (Get-Command peco -ErrorAction SilentlyContinue) {
    function kill-pro { 
        # Ambil daftar unik berdasarkan nama proses agar tidak dobel
        $procName = Get-Process | Select-Object -Property ProcessName -Unique | Out-String -Stream | peco
        
        if ($procName) {
            # Bersihkan spasi yang mungkin terbawa dari peco
            $cleanName = $procName.Trim()
            Stop-Process -Name $cleanName -Force -ErrorAction SilentlyContinue
            Write-Host "Selesai! Semua proses '$cleanName' telah dimatikan. 🎯" -ForegroundColor Green
        }
    }
}

# --- 7. STARTUP DISPLAY ---
if (Get-Command fastfetch -ErrorAction SilentlyContinue) { fastfetch }

Write-Host "`nSelamat beraktivitas, Yosia! Saat ini jam $(Get-Date -Format 'HH:mm')" -ForegroundColor Cyan
Write-Host "Terminal siap digunakan. XAUUSD & Data Science menunggumu! 🚀`n" -ForegroundColor Gray