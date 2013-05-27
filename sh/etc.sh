# Directory fun
alias ..='cd ..'
alias pd='pushd'
alias ...='popd'

# Pivotal tracker fun. http://pt.c4rl.ws
function pt() {
  echo "http://pt.c4rl.ws/s/$1" | tr -d "\n" | pbcopy && echo "http://pt.c4rl.ws/s/$1"
}

function ptp() {
  echo "http://pt.c4rl.ws/p/$1" | tr -d "\n" | pbcopy && echo "http://pt.c4rl.ws/p/$1"
}

function pte() {
  echo "http://pt.c4rl.ws/e/$1" | tr -d "\n" | pbcopy && echo "http://pt.c4rl.ws/e/$1"
}

# UNIX timestamp.
alias ts='date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s"'

# Shortcut to compress and remove a file or directory.
function czf() {
  FILE=$1
  tar -czf $FILE.tar.gz $FILE && rm -rf $FILE
}

# Extract above, and preserve original.
function xzf() {
  FILE=$1
  tar -xzf $FILE
}
