# Directory fun
alias ..='cd ..'
alias pd='pushd'
alias ...='popd'

# Pivotal tracker fun
function pt() {
  echo "http://pt.c4rl.ws/s/$1" | tr -d "\n" | pbcopy && echo "http://pt.c4rl.ws/s/$1"
}

function ptp() {
  echo "http://pt.c4rl.ws/p/$1" | tr -d "\n" | pbcopy && echo "http://pt.c4rl.ws/p/$1"
}

function pte() {
  echo "http://pt.c4rl.ws/e/$1" | tr -d "\n" | pbcopy && echo "http://pt.c4rl.ws/e/$1"
}

# Other stuff

# Shortcut to compress and remove a file or directory.
function czf() {
  FILE=$1
  tar -czf $FILE.tar.gz $FILE && rm -rf $FILE
}
