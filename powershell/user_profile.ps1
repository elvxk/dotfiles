# eval "$(oh-my-posh init bash --config D:/laragon/www/kirby-omp/kirby.omp.json)"

# function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName}
# $PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'kirby.omp.json'

cls

Import-Module Terminal-Icons
oh-my-posh --init --shell pwsh --config  $HOME/.config/powershell/kirby.omp.json | Invoke-Expression

# Set Alias
Set-Alias v nvim
Set-Alias g git
Set-Alias n npm

# Refresh profile pwsh / reload pwsh
function sc {Invoke-Command {& "pwsh.exe" -nologo} -NoNewScope}

# Goto location
function cdw { cd D:/laragon/www }
function cdv { cd $HOME/AppData/Local/nvim }
function kirby { cd D:/laragon/www/kirby-omp }

# npm vite
function nrd { npm run dev -- $args }
function nrb { npm run build }
function nrp { npm run preview }

# Create react app
function cra { npm create vite@latest $args }
function react { git clone https://github.com/elvxk/react-tailwind-starter.git $args}

# Edit file in nvim
function vp { nvim $HOME/.config/powershell/user_profile.ps1 }

# Git
function gcl { git clone $args}
function gf { git fetch }
function gb { git branch $args}
function gs { git status }
function ga { git add . }
function gmit {
  do{
    $commit = Read-Host -Prompt "🍧 Enter commit "
    $commit_check = $commit -replace '\s',''
    if($commit_check){
      Write-Host "" 
      git commit -m $commit
    }else{
      Write-Host " - Please input commit" -ForegroundColor Red
    }
  }while(!($commit_check))
}
function gcp { git commit -m "📦 Paket..." }
function gpull { git pull }
function gpush { git push -u origin $args }

