# Drush fun
alias ddb='drush sql-drop -qy && `drush sql-connect`'
alias dsi='drush si minimal --db-url=mysql://root:root@localhost/d8 --site-mail=carl.wiedemann@gmail.com --account-mail=carl.wiedemann@gmail.com  --account-name=root --site-name=d8 -y && drush uli'
alias cdd='cd `drush dd`'
alias dcc='drush cc all -y && gn "Cached cleared"'
alias mated='mate `drush dd`'
alias dbug='cat /tmp/drupal_debug.txt'
alias mdbug='mate /tmp/drupal_debug.txt'
alias cdbug='cat /dev/null > /tmp/drupal_debug.txt && chmod 777 /tmp/drupal_debug.txt && echo "Cleared /tmp/drupal_debug.txt"'
alias devcss='drush vset cache 0 -y && drush vset preprocess_css 0 -y && drush vset preprocess_js 0 -y && drush vset less_devel 1 -y'
alias prodcss='drush vset cache 1 -y && drush vset preprocess_css 1 -y && drush vset preprocess_js 1 -y && drush vset less_devel 0 -y'
alias dss='drush site-set'
alias dupc="drush upc --no-backup"
# Open drupal debug in Console
alias dcon='open -a /Applications/Utilities/Console.app /tmp/drupal_debug.txt'

# Goto the file that contains the given function
function findfunc {
  grep -rn "function $1(" *| grep -vP "tags|patch$"| awk -F':' '{print $1,$2}' |
  while read FILE LINE
  do
    mate -l ${LINE} ${FILE}
  done
}

# Drupal-codebase specific https://gist.github.com/3954318
function dff {
  grep -rn "function $1(" `drush dd`| grep -vP "tags|patch$"| awk -F':' '{print $1,$2}' |
  while read FILE LINE
  do
    mate -l ${LINE} ${FILE}
  done
}

# Jump to a given module, or custom, or contrib, or core modules.
function mod {
  if [[ $1 == 'custom' ]]; then
    DIR="sites/all/modules/custom"
  elif [[ $1 == 'contrib' ]]; then
    DIR="sites/all/modules/contrib"
  elif [[ $1 == '' ]]; then
    DIR="modules"
  else
    DIR=`drush php-eval "echo drupal_get_path('module', '$1')"`
  fi
  ROOT=`drush dd`
  cd $ROOT/$DIR
}

# Jump to a given theme, or the default theme.
function theme {
  if [[ $1 == '' ]]; then
    THEME=`drush vget --format=json theme_default|replace '"' ''`
  else
    THEME=$1
  fi
  DIR=`drush php-eval "echo drupal_get_path('theme', '$THEME')"`
  ROOT=`drush dd`
  cd $ROOT/$DIR
}
