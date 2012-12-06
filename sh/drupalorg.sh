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