#!/bin/zsh
# publica a pasta pipos-online no github pages com o domínio pipos.online
set -e
GH="$HOME/.local/bin/gh"; DIR="$HOME/Library/CloudStorage/Dropbox/pipos-online"
cd "$DIR"
[ -d .git ] || git init -q -b main
git add -A && git commit -q -m "landing do pipos.online" || true
$GH repo view ricardopizzichini41/pipos >/dev/null 2>&1 || $GH repo create pipos --public --description "pipos.online — a central do ric e da gabi" --source "$DIR" --remote origin
git remote get-url origin >/dev/null 2>&1 || git remote add origin https://github.com/ricardopizzichini41/pipos.git
git push -u origin main
$GH api -X POST repos/ricardopizzichini41/pipos/pages -f build_type=legacy -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 || true
sleep 3
$GH api -X PUT repos/ricardopizzichini41/pipos/pages -f cname=pipos.online >/dev/null 2>&1 || true
echo "publicado ✓  → https://ricardopizzichini41.github.io/pipos  (e pipos.online assim que o dns apontar)"
