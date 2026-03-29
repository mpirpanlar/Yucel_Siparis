@echo off
cd /d D:\DelphiProjeler\Yucel_Siparis

echo ==== MEVCUT DURUM ====
git status

echo.
echo ==== STASH ALINIYOR ====
git stash push -u -m "safe-cleanup-before-ignore"

echo.
echo ==== SADECE BUILD DOSYALARI TRACK'TEN CIKARILIYOR ====
git rm -r --cached --ignore-unmatch Debug
git rm -r --cached --ignore-unmatch Release
git rm -r --cached --ignore-unmatch Win32
git rm -r --cached --ignore-unmatch Win64
git rm -r --cached --ignore-unmatch __history__

git rm --cached --ignore-unmatch *.dcu
git rm --cached --ignore-unmatch *.exe
git rm --cached --ignore-unmatch *.dll
git rm --cached --ignore-unmatch *.bpl
git rm --cached --ignore-unmatch *.dcp
git rm --cached --ignore-unmatch *.identcache
git rm --cached --ignore-unmatch *.local
git rm --cached --ignore-unmatch *.stat
git rm --cached --ignore-unmatch *.dproj.local
git rm --cached --ignore-unmatch *.groupproj.local

echo.
echo ==== .GITIGNORE EKLENIYOR ====
git add .gitignore

echo.
echo ==== COMMIT ====
git commit -m "clean ignored Delphi build artifacts"

echo.
echo ==== GERCEK DEGISIKLIKLER GERI ALINIYOR ====
git stash pop

echo.
echo ==== SON DURUM ====
git status
pause