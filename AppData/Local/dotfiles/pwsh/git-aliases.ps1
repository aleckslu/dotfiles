
Set-Alias -Name g -Value git
function ga {
	git add $args
}

function gcmsg {
	git commit -m $args
}

function gcam {
	git commit -a -m $args
}

Remove-Alias gp -Force -ErrorAction SilentlyContinue
function gp {
	git push $args
}

Remove-Alias gl -Force -ErrorAction SilentlyContinue
function gl {
	git pull $args
}

function gb {
	git branch $args
}

function gco {
	git checkout $args
}

function glog {
	git log --oneline --decorate --color --graph $args
}

function grb {
	git rebase $args
}

function gst {
	git status $args
}

function gd {
	git diff $args
}

