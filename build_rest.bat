@echo off
setlocal
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "DISTUTILS_USE_SDK=1"
set "REPO=C:\Users\SANJAY V S\Documents\4D\4d-gaussian-splatting"

echo ===== BUILDING pointops2 =====
cd /d "%REPO%\pointops2"
"%CONDA_PREFIX%\python.exe" -m pip install . --no-build-isolation
echo ===== pointops2 PIP EXIT: %ERRORLEVEL% =====

echo ===== BUILDING diff-gaussian-rasterization =====
cd /d "%REPO%\diff-gaussian-rasterization"
"%CONDA_PREFIX%\python.exe" -m pip install . --no-build-isolation
echo ===== diffgr PIP EXIT: %ERRORLEVEL% =====

echo ===== IMPORT TEST (all three) =====
"%CONDA_PREFIX%\python.exe" -c "import torch; import simple_knn._C; import pointops2_cuda; import diff_gaussian_rasterization._C; print('ALL THREE EXTENSIONS IMPORT OK')"
echo ===== IMPORT EXIT: %ERRORLEVEL% =====
endlocal
