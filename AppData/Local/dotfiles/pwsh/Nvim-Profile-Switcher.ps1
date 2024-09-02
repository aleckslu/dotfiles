#function lazy
#{
#	$Env:NVIM_APPNAME="dotfiles\nvim-LazyVim"
#	nvim $args
#}

# Function to select Neovim config
function Invoke-Nvims
{
	$items = @("default", "LazyVim", "NvChad")
	$distro = $items | fzf --prompt=" Neovim Config " --height=~50% --layout=reverse --border --exit-0

	if ([string]::IsNullOrEmpty($distro))
	{
		Write-Host "Nothing selected"
		return
	} elseif ($distro -eq "default")
	{
		$distro = ""
	} else
	{
		$distro = "-$distro"
	}

	$env:NVIM_APPNAME = "dotfiles\nvim$distro"
	nvim $args
}

Set-Alias -Name nvims -Value Invoke-Nvims
