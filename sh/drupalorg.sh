#
# Rebase and roll a drupal patch!
#
# I keep my patches in ~/_src/patches so you can adjust that if you want.
#
# Usage:
#
# $> rroll [ISSUE NID] [COMMENT CID TO BE ADDED] [HEAD] [EXISTING PATCH TO INTERDIFF (optional)]
#
#
function rroll() {
  CURRENT=`git branch | grep ^\* | awk '{print \$2}'`
  NAME=${PWD##*/}-$1-$2.patch
  OLDNAME=${PWD##*/}-$1-$4.patch
  DIR=~/_src/patches/
  HEAD=$3
  git rebase $HEAD && git diff $HEAD > $DIR$NAME && echo -e "Patch rolled: $DIR$NAME"

  if [ -f $DIR$OLDNAME ]; then
    # Create the interdiff.
    git checkout $HEAD
    git reset --hard

    git checkout -b _old_patch_ && git apply --index $DIR$OLDNAME && git commit -am 'Old patch'
    git checkout $HEAD

    git checkout -b _new_patch_ && git apply --index $DIR$NAME && git commit -am 'New patch'
    git diff _old_patch_ > $DIR$NAME-interdiff.txt

    git checkout $CURRENT
    git branch -D _old_patch_ && git branch -D _new_patch_

    echo "Created $DIR$NAME-interdiff.txt"

  fi

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