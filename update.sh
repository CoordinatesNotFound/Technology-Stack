sed -i "" '/Structure of Technology Stack:/,$ {/Structure of Technology Stack:/!d;}' README.md

{ echo '```'; tree . -I "update.sh|README.md" ; echo '```'; } >> README.md

git add .
git commit -m $1
git push 