# Roll a patch given an issue number and comment number.
#
# Usage:
#
# $> roll [issue nid] [comment index]
#
# Produces [project name]-[issue nid]-[comment index].patch. Chage the DIR
# below to save in a different directory.
#
function roll() {
  NAME=${PWD##*/}-$1-$2.patch
  DIR=~/_drupal/patches/
  git diff > $DIR$NAME && echo -e "Patch rolled:\n$DIR$NAME"
}

function rroll() {
  NAME=${PWD##*/}-$1-$2.patch
  DIR=~/_drupal/patches/
  BRANCH=$3
  git rebase $BRANCH && git diff $BRANCH > $DIR$NAME && echo -e "Patch rolled:\n$DIR$NAME"
}

# Roll a core patch from a separate branch using the advanced technique.
#
# Usage:
#
# $> roll [issue nid] [comment index]
#
# Produces [project name]-[issue nid]-[comment index].patch. Chage the DIR
# below to save in a different directory.
function croll() {
  NAME=drupal-$1-$2.patch
  DIR=~/_drupal/patches/
  git rebase origin/8.x && git diff origin/8.x > $DIR$NAME && echo -e "Patch rolled:\n$DIR$NAME"
}

# Rebase core.
alias grbc='git rebase origin/8.x'


function gitlink() {
  if [[($1 != '')]] && [[($2 != '')]]; then
    PROJECT=$1
    DIR=~/_drupal/git
    pd $DIR
    if [ -a $PWD/$PROJECT ]; then
      echo "File exists"
    else
      echo "File does not exist"
      git clone --recursive --branch $2 http://git.drupal.org/project/$PROJECT.git
    fi
    ...
    czf $PROJECT && ln -s $DIR/$PROJECT && echo "Archived $PROJECT.tar.gz"
  else
    echo "Specify project name and branch please"
  fi
}

function gitsupply() {
  if [[ $1 != '' ]] && [[ -h $1 ]]; then
    PROJECT=$1
    TEMP=$1_
    cd $PROJECT
    VERSION=`gbc`
    ..
    mkdir $TEMP && cp -r $PROJECT/* $TEMP/ && rm $TEMP/*.info && rm -rf $PROJECT
    drush dl $PROJECT-$VERSION-dev -y && cp -r $TEMP/* $PROJECT/ && rm -rf $TEMP && echo "Supplied $PROJECT-$VERSION-dev"
  else
    echo "Specify dir please"
  fi
}

# https://gist.github.com/Cottser/5588734
function ubench() {
  ./xhprof-kit/upload-bench.sh $XHPROFKITKEY $XHPROFKITID $1 `git rev-parse --abbrev-ref HEAD`
}

alias bbranch='./xhprof-kit/benchmark-branch.sh `git rev-parse --abbrev-ref HEAD`'

function bbranches() {
  originalbranch="$(git rev-parse --abbrev-ref HEAD)"
  base=$1
  shift
  ./xhprof-kit/benchmark-branches.sh $base "$originalbranch" "$originalbranch" "$@"
  git checkout -q "$originalbranch" --
  drush rr
  drush cc all
}

# git completion, comment out for branch completion for bbranch and bbranches commands
# I am using homebrew git and homebrew bash completion, `brew install bash-completion`.
#__git_complete bbranch _git_checkout
#__git_complete bbranches _git_checkout