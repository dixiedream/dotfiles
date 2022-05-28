#! /bin/sh

languages=`echo "golang lua cpp c typescript nodejs php" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk rsync zip tar" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

if printf $languages | grep -qs $selected; then
    curl cht.sh/$selected/`echo $query | tr ' ' '+'`
else
    curl cht.sh/$selected
fi
