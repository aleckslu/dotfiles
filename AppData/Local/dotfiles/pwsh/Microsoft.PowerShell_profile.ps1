oh-my-posh init pwsh --config "$HOME\.config\omp-themes\0-alecks.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$HOME\.config\omp-themes\hul10.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression

### Environment Variables
# extending PATH
# $Env:PATH += ";$Env:APPDATA\FlowLauncher\Plugins\Timer-1.1.0\hourglass;C:\cygwin64\bin"  -- added User env var for these already

# $SURFINGKEYS = "$HOME\.config\surfingkeys"

# Common Paths
# $CARGO_CONFIG = "$Env:USERPROFILE\Cargo.toml"
#               *$XDG_CONFIG_HOME*
# Unix:         ~/.config         
# Windows:      ~/AppData/Local   
#
#
# *$XDG_STATE_HOME* ~/AppData/Local
# *$XDG_DATA_HOME* ~/AppData/Local
# `$NVIM_LOG_FILE` ~/AppData/Local/nvim-data/log
$CONFIG = $Env:XDG_CONFIG_HOME
$DOTFILES = "$CONFIG\dotfiles"
$Env:DOTFILES = $DOTFILES
$Env:EDITOR = "$CONFIG\bob\nvim-bin\nvim.exe"

# Dotfile locations
# $BOB_CONFIG = "$DOTFILES\bob\config.json"
$AHK_HOME = "$DOTFILES\ahk"
$AHK_MAIN = "$AHK_HOME\main.ahk"

# Repo locations
$REPOS = "$HOME\repositories"
$Env:RESUME_HOME = "$HOME\repositories\resumes"
$RESUMES = $Env:RESUME_HOME
# Example repo / config files
$DUMP = "$REPOS\dump" ## move to \dump 
# $CONFIG_DUMP = "$DUMP\dotfiles"

$VIMRC = $Env:MYVIMRC

$Env:OBSIDIAN_VAULT_HOME = "$HOME\obsidian\vaults"
$VAULTS = $Env:OBSIDIAN_VAULT_HOME

## TODO: a list of sub dirs as name of vaults -> loops over -> append to $vaults
$Env:OBSIDIAN_PERSONAL_VAULT = "$VAULTS\Personal"
# $Env:OBSIDIAN_CODE_VAULT = "$Env:OBSIDIAN_VAULT_HOME\Code"
# $Env:OBSIDIAN_GIG_VAULT = "$VAULTS\Gig"

# --walker file,dir,follow,hidden 
$Env:FZF_DEFAULT_OPTS = '--height 60% --border --walker-skip .git,node_modules,dist,build,out,__pycache__,.swp,.swo,`$Windows.~WS,`$WINDOWS.~BT,Video,Windows'
# $Env:FZF_DEFAULT_COMMAND = 'rg --files'

# TODO: update else dirs
$KOMOHOME = if ($Env:KOMOREBI_CONFIG_HOME)
{ $Env:KOMOREBI_CONFIG_HOME
} else
{ "$CONFIG\dotfiles\komorebi" 
}
$WHKDHOME = if ($Env:WHKD_CONFIG_HOME)
{ $Env:WHKD_CONFIG_HOME
} else
{ "$CONFIG\dotfiles\whkd" 
}

$TOD = "$Env:APPDATA\tod.cfg"
# $LAZY = "$CONFIG\nvim-LazyVim"
# $LAZYDIR = "$Env:LOCALAPPDATA\dotfiles\nvim-lazy-data\lazy\LazyVim"
$KFREQ_HOME = "$REPOS\projects\keyfreq"
$KFREQ_DATA_HOME = "$HOME"
$KFREQ_JSON = "$KFREQ_DATA_HOME\key-freq.json" ## TODO: -> private dotfiles repo

## Other files/dirs uncertain if should ignore: ;docs/;doc/;venv/;env/;*.log/;tmp/;temp/;cache/;vendor/*.lock
## TODO: update this
## TODO: Maybe separate ignore list between grep and search.  example: .jpeg or *.log
$Env:SEARCH_DIRS = "$Env:XDG_CONFIG_HOME;$TOD;$REPOS;$VAULTS;$HOME\.yasb;$HOME\key-freq.json;$HOME\.gitignore;$HOME\.gitconfig;$HOME\komorebic.lib.ahk"
$Env:IGNORE_DIRS = ".git/;.svn/;.hg/;node_modules/;dist/;target/;build/;out/;.DS_Store;Thumbs.db;Desktop.ini;.png;.jpeg;.jpg;.mp4;.mkv;.avi;.zip;.tar;.gz;.rar"

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
  Import-Module "$ChocolateyProfile"
}


### Custom Aliases

. "$DOTFILES\pwsh\git-aliases.ps1"

Set-Alias -Name vim -Value nvim.exe
Set-Alias alias Get-Alias
Set-Alias which where.exe
Set-Alias touch New-Item
Set-Alias komo komorebic.exe
Set-Alias grep Select-String
Set-Alias owner Get-Acl
Set-Alias oc onecommander.exe
Set-Alias ls eza.exe
Set-Alias lg lazygit

### Custom Functions
function yasb
{
  param(
    [switch]$r
  )
  if($r)
  {
    Stop-Process -Name python
  }
  Start-Process -FilePath "python" -ArgumentList "$Env:USERPROFILE\repositories\yasb\src\main.py" -WindowStyle Hidden
}

function keyfreq
{
  param(
    [switch]$s,
    [switch]$r
  )

  if ($s)
  {
    Get-Content $KFREQ_JSON | jq '._TOTAL_LOG | to_entries | sort_by(.value) | from_entries'
  } elseif ($r)
  {
    Get-Content $KFREQ_JSON | jq '._TOTAL_LOG | to_entries | sort_by(.value) | reverse | from_entries'
  } else
  {
    python $Env:USERPROFILE\repositories\projects\keyfreq\main.py
  }
}
Set-Alias -Name kf -Value keyfreq

function fonts
{
  [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
	(New-Object System.Drawing.Text.InstalledFontCollection).Families
}

function killWHKD
{
  Stop-Process -Name whkd -Force -ErrorAction SilentlyContinue
}

function killKomo
{
  if (Get-Process -Name "whkd" -ErrorAction SilentlyContinue)
  {
    killWHKD
  }
  if (Get-Process -Name "komorebi" -ErrorAction SilentlyContinue)
  {
    Stop-Process -Name komorebi -Force 
  }
}
Set-Alias -Name stopkomo -Value killKomo

function startWHKD
{
  killWHKD
  Start-Process 'whkd.exe' -Verb RunAs -WindowStyle hidden
}

function startKomo
{
  param(
    [switch]$a, #run as admin
    [switch]$p #kill python
  )

  if (Get-Process -Name "komorebi" -ErrorAction SilentlyContinue)
  {
    Write-Host "Komorebi still running, Killing Now..."
    killKomo
    Write-Host "Stopped Komorebi"
  }
  if($a)
  {
    Write-Host "Debug komohome: $KOMOHOME"
    Start-Process 'komorebi.exe' -Verb RunAs -WindowStyle Hidden -ArgumentList --config="$KOMOHOME\komorebi.json"
    StartWHKD
  } else
  {
    Write-Host "Debug komohome: $KOMOHOME"
    komorebic start -c "$KOMOHOME\komorebi.json" --whkd --bar
  }
  if ($p)
  {
    Stop-Process -Name python -ErrorAction SilentlyContinue
  }
  Write-Host "Komorebi started"
  yasb
  # . "$DOTFILES\pwsh\komorebi.generated.ps1"
}

function rcopy
{
  Write-Host $($args[0])
  Write-Host $($args[1])
  robocopy $($args[0]) $($args[1]) /W:0 /R:3 /E /V /XJD /TEE /ETA /DCOPY:T /FP /XA:O /MT:15
}

function test-service
{
  param (
    [string]$serviceName
  )
  $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
  return -not ($null -eq $service) -and $service.Status -eq 'Running'
}

function nvimf
{
  $fzfInput = (fzf)
  if ($fzfInput)
  {
    $path = Convert-Path($fzfInput)
    if (Test-Path -Path $path -PathType Container)
    {
      Set-Location $path
    } else
    {
      $parentpath = Split-Path -Parent $path
      $maxDepth = 3
      $additionalGitDepth = 3

      $parentpath = Find-ParentDirectory -FilePath $path -TargetDirectory '.git' -Depth $maxDepth -ReturnEndPath # -Log
      $gitDir = Find-ParentDirectory -FilePath $path -TargetDirectory '.git' -Depth $additionalGitDepth # -Log
      if ($gitDir)
      {
        $parentpath = $gitDir
      }
			
      # maxDepth - if .git found, cd to it, otherwise cd to maxDepth
      # additionalGitDepth - if .glit found, cd to it, other just cd to maxDepth
      if ($parentpath -ne $path)
      {
        __zoxide_z $parentpath
      }
    }
    # Write-Host "nvim : $path"
    nvim $path
  }
}

# elseif ($parentpath -ne (''))
# {
# 	# Find closest parent git dir within maxdepth
# 	$MaxDepth = 2
# 	$MaxGitDepth = 5
#
# 	# debug
# 	if ($MaxDepth -gt $MaxGitDepth)
# 	{
# 		return 'Error: $MaxGitDepth needs to be Greater Than or Equal To $MaxDepth'
# 	}
#
# 	while ($MaxDepth -gt 0 -and (
# 			$MaxGitDepth -gt 0
# 		) -and (
# 			Test-Path -Path $parentpath -PathType Container
# 		) -and -not (
# 			Test-Path -Path (
# 				Join-Path -Path $parentpath -ChildPath '.git'
# 			) -PathType Container
# 	
# 		))
# 	{
# 		$parentpath = Split-Path -Parent $parentpath
# 		$MaxDepth--
# 		$MaxGitDepth--
# 	}
# 	# maxd - loop till maxd and set path to this
# 	# loop until maxgitd tostop 
# 	__zoxide_z $parentpath
# }

# function resume
# {
# 	param (
# 		[switch]$l
# 	)
# 	Set-Location $RESUMES
# 	if ($l)
# 	{
# 		lazy $RESUMES
# 	} else
# 	{
# 		nvim $RESUMES
# 	}
# }

### Bash / Zsh equivalents

# function cdf
# {
# 	fzf --walker="dir,hidden,follow" | Set-Location
# }

function startAHK
{
  if ($AHK_MAIN)
  {
    Write-Host "Starting Main AHK Script..."
    Start-Process "$AHK_MAIN"
  }
}

# Open Obsidian Vaults in Neovim
# function obs
# {
# 	param (
# 		[switch]$code, #code vault
# 		[switch]$c, #code vault alias
# 		[switch]$gig, #gig vault
# 		[switch]$g #gig vault alias
# 	)
#
# 	if ($code -or $c)
# 	{
# 		$vault = $GIG_VAULT
# 	} elseif ($gig -or $g)
# 	{
# 		$vault = $GIG_VAULT
# 	} else
# 	{
# 		$today = Get-Date -Format 'yyyy-MM-dd'
# 		$vault = [string]::Concat($PERSONAL_VAULT, '\Daily\', $today, '.md')
# 	}
# 	Set-Location $OBS
# 	nvim $vault
# }

# Define a function to compare two lists
function comparelist
{
  param (
    [string]$list1,
    [string]$list2
  )

  # Convert the input strings into arrays of words/phrases
  $array1 = $list1 -split "`n" | Where-Object { $_ -ne '' } | ForEach-Object { $_.Trim() }
  $array2 = $list2 -split "`n" | Where-Object { $_ -ne '' } | ForEach-Object { $_.Trim()}
  # Find words/phrases in array1 that are not in array2
  $result = $array1 | Where-Object { $_ -NotIn $array2 }
  # Output the result
  return $result
}

function wingetup
{
  winget upgrade $args --accept-package-agreements --accept-source-agreements
}

function updateAll
{
  ## TODO: check of admin privaledges first
  choco upgrade all -y
  wingetup --all
}

# function appsearch
# {
# 	if ($args.Count -ne 1)
# 	{		
# 		Write-Host $args.Count
# 		Write-Host $args[0]
# 		return 'Expected 1 argument[string] for package name'
# 	}
#
# 	Write-Host "  __________________________" -ForegroundColor Green
# 	Write-Host "[[ Choco Results for: $args ]]" -ForegroundColor Green
# 	Write-Host " ----------------------------" -ForegroundColor Green
# 	choco search $args[0]
# 	Write-Host "  ___________________________" -ForegroundColor Green
# 	Write-Host "[[ Winget Results for: $args ]]" -ForegroundColor Green
# 	Write-Host " -----------------------------" -ForegroundColor Green
# 	winget search $args[0]
# }

function Find-ParentDirectory
{
  param (
    #[Parameter(Mandatory=$true, Position=0)]
    [Parameter(Mandatory=$true)]
    [Alias("p")]
    [string]$FilePath,
        
    [Parameter(Mandatory=$true)]
    [Alias("dir")]
    [string]$TargetDirectory,
        
    [Alias("dep")]
    [double]$Depth = [double]::PositiveInfinity,

    [Alias("ex")]
    [string[]]$Exclude = @(), #paths to exlude from search

    [Alias('ret')]
    [switch]$ReturnEndPath,

    [Alias('l')]
    [switch]$Log

  )

  ### Log arguments
  if ($Log)
  {
    Write-Host "[[ARGS:]]" -ForegroundColor Green
    foreach ($param in $PSBoundParameters.Keys)
    {
      $arg = $PSBoundParameters[$param]
      Write-Host "$param : $arg" -ForegroundColor Green
    }
    Write-Host "-------------------" -ForegroundColor Green
  }
  ###

  $alwaysExclude = $Env:USERPROFILE, 'C:\'
  $absPath = [System.IO.Path]::GetFullPath($FilePath)
  $pathRoot = [System.IO.Path]::GetPathRoot($absPath)
  $currentDepth = 0

  $currentDirectory = if (Test-Path -Path $absPath -PathType Container)
  {
    $absPath
  } else
  {
    [System.IO.Path]::GetDirectoryName($absPath)
  }
  $currentParentDirectory = Split-Path -Parent $currentDirectory

  while ($currentParentDirectory -ne $pathRoot -and -not ($alwaysExclude | Where-Object({$currentParentDirectory -eq $_})) -and ($currentDepth -lt $Depth))
  {
    ### DEBUG
    if ( $Log -and ($alwaysExclude | Where-Object {$currentParentDirectory -eq $_}))
    {
      Write-Host "Where Obj" -ForegroundColor Red
      Write-Host ($alwaysExclude | Where-Object({$currentParentDirectory -eq $_})) -ForegroundColor Red
      Write-Host "-----------" -ForegroundColor Red
      Write-Host "Dir in Exclusion List: $currentParentDirectory" -ForegroundColor Red
      Write-Host "current dir: $currentDirectory" -ForegroundColor Red
    }
    ###

    # Check if the target directory exists in the current directory
    $targetPath = Join-Path -Path $currentDirectory -ChildPath $TargetDirectory
    if ($Exclude | Where-Object( { $currentDirectory -like $_}))
    {

    } elseif (Test-Path -Path $targetPath -PathType Container)
    {
      if ($Log)
      { Write-Host "Found .git in: $currentDirectory" -ForegroundColor DarkGreen
      }
      return $currentDirectory
    }
    $currentDirectory = $currentParentDirectory
    $currentParentDirectory = Split-Path -Parent $currentDirectory
    $currentDepth++
  }
  # Return null if the target directory is not found
  # or should i return empty string
  if ($ReturnEndPath)
  {
    return $currentDirectory
  }
  return ''
}

function startup
{
  # while (
  #   -not (Get-Process -Name "Obsidian" -ErrorAction SilentlyContinue) 
  # )
  # {
  #   Start-Sleep -Seconds 1
  # }

  Write-Host "Starting main.ahk"
  startAHK
  Write-Host "Starting Google Calendar"
  Start-Process "C:\Users\aleck\OneDrive\Desktop\Google Calendar.lnk"

  startkomo -a
  # Start-Process 'komorebi.exe' -Verb RunAs -WindowStyle Hidden -ArgumentList --config="$KOMOHOME\komorebi.json"
  # Start-Process 'whkd.exe' -Verb RunAs -WindowStyle hidden
  do
  {
    Write-Host "Waiting for Komorebi to start..."
    Start-Sleep -Seconds 1
  } while (-not (Get-Process -Name "komorebi" -ErrorAction SilentlyContinue))
  Write-Host "Komorebi started"
  # . "$DOTFILES\pwsh\komorebi.generated.ps1"
  # yasb
  Write-Host "Starting KFreq"
  keyfreq
}


#### Test a File/Path and makes sure it and all its parent directories grant curent user full control
# function Test-FullControl
# {
# 	param (
# 		[string]$path,
# 		[string]$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
# 	)
#
# 	while ($path -ne [System.IO.Path]::GetPathRoot($path))
# 	{
# 		$acl = Get-Acl $path
# 		$hasFullControl = $acl.Access | Where-Object {
# 			# Write-Host "idref: $($_.IdentityReference)"
# 			# Write-Host "user: $user"
# 			# Write-Host "idref $($_.IdentityReference -match $user)"
# 			# Write-Host "rights $($_.FileSystemRights -eq 'FullControl')"
# 			$_.IdentityReference -eq $user -and $_.FileSystemRights -eq 'FullControl'
# 		}
# 		if ($null -eq $hasFullControl)
# 		{
# 			Write-Output "No Full Control for $user on $path, hasFullControl: $hasFullControl"
# 			return $false
# 		}
# 		$path = [System.IO.Path]::GetDirectoryName($path)
# 	}
# 	Write-Output "Full Control for $user on all directories in the path."
# 	return $true
# }


# Check all files, dirs, sub-dirs in a directory for FullControl
# function Check-Permissions
# {
# 	param (
# 		[string]$path
# 	)
#
# 	$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
# 	# Get all items in the directory
# 	$items = Get-ChildItem -Path $path -Recurse -Force
#
# 	# Add the directory itself to the list
# 	$items += Get-Item -Path $path
#
# 	foreach ($item in $items)
# 	{
# 		# Get the ACLs for the item
# 		$acl = Get-Acl -Path $item.FullName
#
# 		# Check if the user has Full Control
# 		$hasFullControl = $false
# 		foreach ($access in $acl.Access)
# 		{
# 			if ($access.IdentityReference -eq $user -and $access.FileSystemRights -eq "FullControl")
# 			{
# 				$hasFullControl = $true
# 				break
# 			}
# 		}
#
# 		if (-not $hasFullControl)
# 		{
# 			Write-Output "User $user does not have Full Control over: $($item.FullName)"
# 			return $false
# 		} 
# 	}
# 	
# 	return $true
# }

#### logs window title
# Add-Type  @"
#  using System;
#  using System.Runtime.InteropServices;
#  using System.Text;
# public class APIFuncs
#    {
#     [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
#    public static extern int GetWindowText(IntPtr hwnd,StringBuilder
# lpString, int cch);
#     [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)]
#    public static extern IntPtr GetForegroundWindow();
#     [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)]
#        public static extern Int32 GetWindowThreadProcessId(IntPtr hWnd,out
# Int32 lpdwProcessId);
#     [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)]
#        public static extern Int32 GetWindowTextLength(IntPtr hWnd);
#     }
# "@
#  
# while(1)
# {
# $w = [apifuncs]::GetForegroundWindow()
# $len = [apifuncs]::GetWindowTextLength($w)
# $sb = New-Object text.stringbuilder -ArgumentList ($len + 1)
# $rtnlen = [apifuncs]::GetWindowText($w,$sb,$sb.Capacity)
# write-host "Window Title: $($sb.tostring())"
# sleep 1
# } 



# Shows navigable menu of all options when hitting Tab
# Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for pwsh
# Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward


if (where.exe yazi)
{
  . $DOTFILES\pwsh\yazi-wrapper.ps1
}
# Neovim Config Picker
# . $DOTFILES\pwsh\Nvim-Profile-Switcher.ps1

# sourcing bob-nvims auto completions
. $HOME\bob_pwsh_completion.ps1


Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
