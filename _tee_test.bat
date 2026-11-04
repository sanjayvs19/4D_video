@echo off
(echo aa & echo bb & echo cc) | powershell -NoProfile -Command "$input | Tee-Object -FilePath 'D:\4D\_tee2.log'"
echo done
