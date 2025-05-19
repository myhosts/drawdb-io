#!/bin/bash

set -euo pipefail

# === 配置 ===
REPO_UPSTREAM="https://github.com/drawdb-io/drawdb.git"
REPO_TARGET="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/myhosts/drawdb-io.git"
DOMAIN_NAME="gh.drawdb.vhosts.top"

# === 工具函数 ===

run_cmd() {
  "$@" || { echo "❌ 命令失败: $*"; exit 1; }
}

get_latest_commit() {
  curl --silent "https://api.github.com/repos/drawdb-io/drawdb/commits" | jq -r '.[0].sha'
}

# === 版本检测 ===

{
  echo "🔍 检查最新 commit..."
  today_commit=$(get_latest_commit)
  current_commit=$(cat currentcommit 2>/dev/null || echo "")

  echo "📌 当前 commit: $current_commit"
  echo "📥 最新 commit:  $today_commit"

  if [[ "$current_commit" == "$today_commit" ]]; then
    echo "✅ 无需更新，退出。"
    exit 0
  fi
}

# === Git 配置 ===

{
  echo "🔧 配置 Git 用户信息..."
  git config --global user.name "github-actions[bot]"
  git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
}

# === 构建项目 ===

{
  echo "📦 克隆并构建项目..."
  rm -rf code
  run_cmd git clone "$REPO_UPSTREAM" code
  cd code

  run_cmd npm ci
  run_cmd npm run build
}

# === 发布到 gh-pages ===

{
  echo "🚀 发布到 gh-pages..."
  cd dist
  rm -rf .git
  git init
  run_cmd git remote add origin "$REPO_TARGET"
  run_cmd git checkout -b gh-pages

  echo "$DOMAIN_NAME" > CNAME

  run_cmd git add -A
  run_cmd git commit -m "deploy commit $today_commit"
  run_cmd git push -u origin gh-pages --force
}

# === 更新 main 分支中的 commit 记录 ===

{
  echo "📝 更新当前 commit 记录..."
  cd ../..
  echo "$today_commit" > currentcommit
  git add currentcommit
  git commit -m "🔄 自动更新版本至 $today_commit"
  git push -f "$REPO_TARGET" main
}

echo "✅ 全部完成。"