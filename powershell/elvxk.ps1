# cd $PSHOME Profile.ps1
# . $env:USERPROFILE\.config\powershell\elvxk.ps1

# Dependencies
# chocolatey = Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
# Terminal Icons = Install-Module -Name Terminal-Icons -Repository PSGallery
# oh-my-posh = Install-Module -Name oh-my-posh -Repository PSGallery

# choco helpers 
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

# Delete watermark pwsh
Clear-Host

# Import terminal icons / https://github.com/devblackops/Terminal-Icons
Import-Module Terminal-Icons

# init oh my posh / https://ohmyposh.dev/docs/themes
oh-my-posh --init --shell pwsh --config  $HOME/.config/powershell/kirby.omp.json | Invoke-Expression

# Set Alias
Set-Alias v nvim
Set-Alias g git
Set-Alias n npm

function q
{
  Invoke-command -ScriptBlock {exit}
}

# Refresh profile pwsh / reload pwsh
function sc
{
  Invoke-Command {& "pwsh.exe" -nologo} -NoNewScope
}

# Goto location
function cdw
{
  Set-Location D:/laragon/www
}
function cdv
{
  Set-Location $HOME/AppData/Local/nvim
}
function kirby
{
  Set-Location D:/laragon/www/kirby-omp
}
function cdc
{
  Set-Location $HOME/.config/
}
function cda
{
  Set-Location $HOME/AppData/Roaming/alacritty/
}

# npm vite
function nrd
{
  npm run dev -- $args
}
function nrb
{
  npm run build
}
function nrp
{
  npm run preview
}

# Create react app
function cra
{
  npm create vite@latest $args
}
function react
{
  git clone https://github.com/elvxk/react-tailwind-starter.git $args
}

# Edit file in nvim
function vp
{
  nvim $HOME/.config/powershell/user_profile.ps1
}

# Git
function gcl
{
  git clone $args
}
function gf
{
  git fetch
}
function gb
{
  git branch $args
}
function gs
{
  git status
}
function ga
{
  git add .
}
function gmitt
{
  do
  {
    $commit = Read-Host -Prompt "🍧 Enter commit "
    $commit_check = $commit -replace '\s',''
    if($commit_check)
    {
      Write-Host ""
      git commit -m $commit
    } else
    {
      Write-Host " - Please input commit" -ForegroundColor Red
    }
  }while(!($commit_check))
}
function gcp
{
  git commit -m "📦 Paket..."
}
function gpull
{
  git pull
}
function gpush
{
  git push -u origin $args
}

function gmit
{
# Daftar pilihan jenis komit
$commitTypes = @(
    @{ Icon = "🎉"; Label = "init"; Description = "New initial"; Selected = $false },
    @{ Icon = "✨"; Label = "feat"; Description = "New feature"; Selected = $false },
    @{ Icon = "🐛"; Label = "fix"; Description = "Bug fix"; Selected = $false },
    @{ Icon = "💡"; Label = "update"; Description = "General update"; Selected = $false },
    @{ Icon = "🔨"; Label = "refactor"; Description = "Code refactor"; Selected = $false },
    @{ Icon = "📚"; Label = "docs"; Description = "Documentation update"; Selected = $false },
    @{ Icon = "🚨"; Label = "test"; Description = "Adding or updating tests"; Selected = $false },
    @{ Icon = "🐎"; Label = "perf"; Description = "Performance improvements"; Selected = $false }
    @{ Icon = "🔥"; Label = "remove"; Description = "Remove code"; Selected = $false }
)

# Fungsi untuk menampilkan pilihan
function Show-Choices {
    param(
        [int]$selectedIndex
    )
    Clear-Host
    Write-Host "`e[32m󰜛 Choose commit type `e[0m:"
    for ($i = 0; $i -lt $commitTypes.Count; $i++) {
        if ($i -eq $selectedIndex) {
            Write-Host "`e[33m $($commitTypes[$i].Icon) $($commitTypes[$i].Label) $(" " * (8 - $($commitTypes[$i].Label).Length)): $($commitTypes[$i].Description)`e[0m"
        } else {
            Write-Host "  $($commitTypes[$i].Icon) $($commitTypes[$i].Label) $(" " * (8 - $($commitTypes[$i].Label).Length)): $($commitTypes[$i].Description)"
        }
    }
}

# Menampilkan pilihan awal
$selectedIndex = 0
Show-Choices -selectedIndex $selectedIndex

# Mengolah input pengguna
do {
    $key = $host.UI.RawUI.ReadKey("IncludeKeyDown,NoEcho").VirtualKeyCode
    if ($key -eq 38 -and $selectedIndex -gt 0) { # Tombol panah atas
        $selectedIndex--
        Show-Choices -selectedIndex $selectedIndex
    } elseif ($key -eq 40 -and $selectedIndex -lt ($commitTypes.Count - 1)) { # Tombol panah bawah
        $selectedIndex++
        Show-Choices -selectedIndex $selectedIndex
    } elseif ($key -eq 13) { # Enter
        $commitTypes[$selectedIndex].Selected = -not $commitTypes[$selectedIndex].Selected
        Show-Choices -selectedIndex $selectedIndex
    }
} while ($key -ne 13)

  do
  {
    $commit = Read-Host -Prompt "`e[32m󰜛 Enter commit message `e[0m"
    $commit_check = $commit -replace '\s',''
    if(!($commit_check))
    {
      Write-Host " Please input commit..." -ForegroundColor Red
    }
  }while(!($commit_check))

# Menampilkan opsi yang dipilih
$selectedOptions = $commitTypes | Where-Object { $_.Selected } | ForEach-Object { $_.Label }
$selectedIcon = $commitTypes | Where-Object { $_.Selected } | ForEach-Object { $_.Icon }
Write-Host ""
Write-Host "`e[32mCommit successfully with message : `e[33m"$selectedIcon"["$selectedOptions"] "$commit"`e[0m"
Write-Host ""
git commit -m $selectedIcon"["$selectedOptions"] "$commit
}
