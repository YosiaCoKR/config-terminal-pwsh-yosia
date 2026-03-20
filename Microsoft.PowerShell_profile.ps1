# =====================================================================
#  🚀 YOSIA SIPAHUTAR - ULTIMATE CLEAN GIT CONFIG (FIXED)
# =====================================================================

# --- 1. TAMPILAN & WINDOW ---
$host.ui.RawUI.WindowTitle = "Yosiasp Terminal 🚀"
clear -x

# --- 2. INITIALIZATION (Theme & Tools) ---
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\clean-detailed.omp.json" | Out-String | Invoke-Expression
}
if (Get-Command zoxide -ErrorAction SilentlyContinue) { 
    zoxide init powershell --hook pwd | Out-String | Invoke-Expression 
}
if (Get-Command atuin -ErrorAction SilentlyContinue) { 
    atuin init powershell | Out-String | Invoke-Expression 
}

# --- 3. MODUL ---
Import-Module -Name Terminal-Icons -ErrorAction SilentlyContinue
Import-Module -Name posh-git -ErrorAction SilentlyContinue
Import-Module PSReadLine

# --- 4. PREDIKSI & HISTORY (PSReadLine) ---
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key 'Ctrl+r' -Function HistorySearchBackward

# --- 5. ALIAS & TOOLS (FORCE OVERWRITE) ---
# Hapus alias bawaan Windows yang sering bentrok
$systemAliases = @("ls", "dir", "cat", "gc", "ga", "gp", "gl", "gb", "gs")
foreach ($a in $systemAliases) { if (Get-Alias $a -ErrorAction SilentlyContinue) { Remove-Item Alias:$a -Force } }

# Alias Umum
Set-Alias -Name sudo -Value gsudo -ErrorAction SilentlyContinue
function ll-func { eza -l --icons --group-directories-first $args }
function ls-func { eza --icons --group-directories-first $args }
function cat-func { bat --paging=never $args }
Set-Alias ls ls-func
Set-Alias ll ll-func
Set-Alias cat cat-func

# --- 6. GIT POWER-PACK (FIXED & BOLD) ---
# Functions dasar agar bisa terima argumen dengan benar
function ga-func { git add . }
function gs-func { git status }
function gc-func { param($msg) git commit -m "$msg" } # Pake param biar lebih stabil
function gp-func { git push }
function gl-func { git pull }
function gb-func { git branch }
function gco-func { param($branch) git checkout $branch }
function gnb-func { param($branch) git checkout -b $branch }

# Set Aliases Git
Set-Alias ga ga-func
Set-Alias gs gs-func
Set-Alias gc gc-func
Set-Alias gp gp-func
Set-Alias gl gl-func
Set-Alias gb gb-func
Set-Alias gco gco-func
Set-Alias gnb gnb-func

# Fungsi Tambahan (Reset, Diff, Stash)
function gsh { git stash }                                         
function gsp { git stash pop }                                     
function gsl { git stash list }
function gd { git diff }                                           
function gds { git diff --staged }                                 
function glog { git log --oneline --graph --all }                  
function grv { git remote -v }
function grs { param($file) git restore --staged $file }                
function grh { git reset --hard HEAD }                             
function guc { git reset --soft HEAD~1 }                           

# Combo
function gacp { param($msg) git add . ; git commit -m "$msg" ; git push }

# --- 7. TROUBLESHOOTING & UTILITIES ---
function kport {
    $proc = Get-NetTCPConnection -State Listen | 
        Select-Object LocalPort, @{Name="ProcessName";Expression={(Get-Process -Id $_.OwningProcess).ProcessName}}, OwningProcess | 
        Out-String -Stream | peco --prompt "Pilih Port yang mau di-KILL >"
    if ($proc) {
        $pidToKill = ($proc.Trim() -split '\s+')[-1]
        Stop-Process -Id $pidToKill -Force
        Write-Host "🎯 Proses PID $pidToKill sukses dimatikan!" -ForegroundColor Green
    }
}

function kill-pro { 
    if (Get-Command peco -ErrorAction SilentlyContinue) {
        $procName = Get-Process | Select-Object -Property ProcessName -Unique | Out-String -Stream | peco --prompt "Matikan Proses >"
        if ($procName) {
            Stop-Process -Name $procName.Trim() -Force -ErrorAction SilentlyContinue
            Write-Host "Selesai! '$($procName.Trim())' telah dimatikan. 🎯" -ForegroundColor Green
        }
    }
}

function f { if (Get-Command fzf -ErrorAction SilentlyContinue) { fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" } }

# Daily Misc
function gold { curl -s rate.sx/XAU | Select-Object -First 15 }
function cuaca { curl -s wttr.in/Jakarta?0pq }
function copy { $input | clip }
function clean-py { Get-ChildItem -Recurse -Filter "__pycache__" | Remove-Item -Recurse -Force }

# --- 8. STARTUP DISPLAY ---
if (Get-Command fastfetch -ErrorAction SilentlyContinue) { fastfetch }

Write-Host "`nSelamat beraktivitas, Yosia! Saat ini jam $(Get-Date -Format 'HH:mm')" -ForegroundColor Cyan
Write-Host "Terminal siap digunakan 🚀 (Coba ketik 'gs' buat tes!)`n" -ForegroundColor Gray