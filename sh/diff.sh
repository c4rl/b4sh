function ddiff() {
  URL=$1
  # Get clean output
  # http d8clean.localhost/$URL Cookie:$DRUPALCOOKIECLEAN > /tmp/d8clean-tmp.html
  wget --no-cookies --header "Cookie: $DRUPALCOOKIECLEAN" http://d8clean.localhost/$URL -O /tmp/d8clean-tmp.html
  # Get patched output
  # http d8.localhost/$URL Cookie:$DRUPALCOOKIE > /tmp/d8.html
  wget --no-cookies --header "Cookie: $DRUPALCOOKIE" http://d8.localhost/$URL -O /tmp/d8.html
  # Make domains similar
  sed -e 's/d8clean/d8/g' /tmp/d8clean-tmp.html > /tmp/d8clean.html
  # Kaleidescope diff
  ksdiff /tmp/d8clean.html /tmp/d8.html
}

alias daisyd='java -jar daisydiff.jar /tmp/d8clean.html /tmp/d8.html && open daisydiff.htm'