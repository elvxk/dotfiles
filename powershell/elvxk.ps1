# cd $PSHOME Profile.ps1
# . $env:USERPROFILE\.config\powershell\elvxk.ps1

# Dependencies
# chocolatey = Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
# Terminal Icons = Install-Module -Name Terminal-Icons -Repository PSGallery
# oh-my-posh = Install-Module -Name oh-my-posh -Repository PSGallery

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
function gmit
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

