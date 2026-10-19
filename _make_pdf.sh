#!/bin/bash
# index.html（日英中切替入り）から A4 の PDF 版を日英中で作り直す → pdf/4001_{ja,en,zh}.pdf ＋ スマホ用ビューア pdf/view.html
# 日本語本文を直したら: _晴海フラッグ_i18n/before/4001.html を直す → python3 _晴海フラッグ_i18n/apply_site.py <ここ> → これ → _deploy.sh kks
set -e
cd "$(dirname "$0")"
node _tools/ovl_images.mjs "$PWD"                                   # 重ね文字付きの図を言語別画像に
for f in img/s01_structure_??.png img/u00_plan2d_??.png; do python3 -c "from PIL import Image;Image.open('$f').convert('RGB').save('${f%.png}.jpg',quality=88)"; rm "$f"; done
python3 /Users/leetenki/AI_share/.claude/skills/property-site/scripts/make_pdf_brochure.py "$PWD" --name 4001
V=$(grep -o 'view.html?lang=ja&v=[0-9a-z]*' index.html | head -1 | sed 's/.*&//')
python3 _tools/make_viewer.py "$PWD" "$V"
ls -la pdf/*.pdf
