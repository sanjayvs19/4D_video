@echo off
setlocal
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Scripts;%PATH%"
cd /d "D:\4D\4d-gaussian-splatting"
"%CONDA_PREFIX%\python.exe" scripts\n3v2blender_win.py data/N3V/hacknex --seconds 2 --fps 30 --max_image_size 1500
echo ===== PREPROCESS EXIT: %ERRORLEVEL% =====
endlocal
