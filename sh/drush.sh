# Drush fun
alias ddb='drush sql-drop -y && `drush sql-connect`'
alias cdd='cd `drush dd`'
alias dcc='drush cc all -y && echo "Cached cleared"'
alias mated='mate `drush dd`'
alias dbug='cat /tmp/drupal_debug.txt'
alias mdbug='mate /tmp/drupal_debug.txt'
alias cdbug='cat /dev/null > /tmp/drupal_debug.txt && chmod 777 /tmp/drupal_debug.txt && echo "Cleared /tmp/drupal_debug.txt"'
alias devcss='drush vset cache 0 -y && drush vset preprocess_css 0 -y && drush vset preprocess_js 0 -y && drush vset less_devel 1 -y'
alias prodcss='drush vset cache 1 -y && drush vset preprocess_css 1 -y && drush vset preprocess_js 1 -y && drush vset less_devel 0 -y'

# Goto the file that contains the given function
function findfunc {
  grep -rn "function $1(" *| grep -vP "tags|patch$"| awk -F':' '{print $1,$2}' |
  while read FILE LINE
  do
    mate -l ${LINE} ${FILE}
  done
}
# Drupal codebase specific https://gist.github.com/3954318
function dff {
  grep -rn "function $1(" `drush dd`| grep -vP "tags|patch$"| awk -F':' '{print $1,$2}' |
  while read FILE LINE
  do
    mate -l ${LINE} ${FILE}
  done
}
