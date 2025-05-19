#!/bin/bash

set -eu

# 版本校验
today_commit=$(curl --silent "https://api.github.com/repos/drawdb-io/drawdb/commits" | jq '.[0].sha' -r)
current_commit=$(cat currentcommit)

echo "current_commit:$current_commit commit:$today_commit"
# 判断版本号是否相同 如果相同就exit
if [[ "$current_commit" == "$today_commit" ]]; then
    exit
fi

echo "System initialization"
git config --global user.name "github-actions[bot]"
git config --global user.email  "41898282+github-actions[bot]@users.noreply.github.com"
echo machine github.com login $GITHUB_USER password $GITHUB_TOKEN > ~/.netrc

echo "Updating code repository in progress..."
echo "Package and publish nodes"
git clone https://github.com/drawdb-io/drawdb.git code
cd code
npm ci
npm run build

cd dist
rm -rf .git
git init
git remote add origin https://github.com/myhosts/drawdb-io.git || { echo "git remote add origin failed"; exit 1; }
git branch -M gh-pages  || { echo "git branch -M gh-pages failed"; exit 1; }
echo 'gh.drawdb.vhosts.top' > CNAME
git add -A || { echo "git add -A failed"; exit 1; }
git commit -m "deploy commit $today_commit" || { echo "git commit failed"; exit 1; }
git push -u origin gh-pages --force || { echo  "Git push failed"; exit 1; } 

cd ..
cd ..

echo "main branch Version update"
echo "$today_commit" >currentcommit
git add currentcommit
git commit -a -m "Automatically update version to  $today_commit"
git push -f https://github.com/myhosts/drawdb-io.git main