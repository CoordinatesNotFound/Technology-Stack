sed -i "" '/Structure of Knowledge Base:/,$ {/Structure of Knowledge Base:/!d;}' README.md

{ echo '```'; tree .; echo '```'; } >> README.md

git add .
git commit -m $1
git push 