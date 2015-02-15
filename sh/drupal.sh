function moduleinit {
  NAME=$1
  MSG="Created module $1"
  mkdir $NAME && touch $NAME/$NAME.module && touch $NAME/$NAME.info && echo $MSG
}
