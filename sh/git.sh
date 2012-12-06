# Git fun
alias ga='git add'
alias gb='git branch -av'
alias gss='git status -s'
alias gsl='git status -s | less'
alias gd='git diff --color'
alias gdc='git diff --cached --color'
alias gcm='git commit -m'
alias gcam='git commit -am'
function gcamp() {
  git commit -am "$1" && git push
}
alias gcob='git checkout -b'
alias gp='git push'
# Remove deleted files
alias grm="git status -s . | grep '^ D' | awk '{print \$2}' | xargs git rm"
# Return current branch name
alias gbc="git branch | grep ^\* | awk '{print \$2}'"
# Delete branch name
alias gbd='git branch -d'
# Goto master.
alias gh='gco master'

# Delete the current branch if merged into master.
function gitkill() {
  # Get branch we are on
  CURRENT=`gbc`
  git checkout master && git branch -d $CURRENT && growlnotify -m "$CURRENT deleted"
}

# Checkout [to branch], merge --no-ff [current branch] with auto message,
# push [to branch] to remote, & re-checkout current.
#
# Usage: (From [current branch])
#
# $> gitdeploy [to branch]
#
function gitdeploy() {
  # Get branch we are on
  CURRENT=`gbc`
  git checkout $1 && git pull && git merge --no-ff $CURRENT -m "Merging $CURRENT" && git push && git checkout $CURRENT && growlnotify -m "$CURRENT > $1"
}

# Resolve a subdirectory code upgrade (like drush upc) via git. Move into a
# directory, get rid of old stuff, add new stuff, commit with auto message.
#
# Usage:
#
# $> gup [dirname]
#
function gup() {
  DIR=$1
  pd $DIR && ga . && grm && gcm "Upgrade $DIR" && ...
}

export GIT_PS1_SHOWDIRTYSTATE=true
