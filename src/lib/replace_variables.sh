# Function to replace variables in a string
function replace_variables {
  local str="$1"
  local replacements="$2"
  local varname varval
  for pair in ${replacements}; do
    IFS='=' read -r varname varval <<<"$pair"
    str=$(echo "$str" | sed "s#\${${varname}}#${varval}#g")
  done
  echo "$str"
}
