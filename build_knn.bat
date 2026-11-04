@echo off
setlocal
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "DISTUTILS_USE_SDK=1"
echo ===== CL VERSION =====
cl 2>&1 | findstr /C:"Version"
echo ===== NVCC VERSION =====
nvcc --version | findstr /C:"release"
echo ===== BUILDING simple-knn =====
cd /d "C:\Users\SANJAY V S\Documents\4D\4d-gaussian-splatting\simple-knn"
"%CONDA_PREFIX%\python.exe" -m pip install . --no-build-isolation
echo ===== BUILD EXIT CODE: %ERRORLEVEL% =====
echo ===== IMPORT TEST =====
"%CONDA_PREFIX%\python.exe" -c "import simple_knn._C; print('simple_knn._C OK')"
echo ===== IMPORT EXIT CODE: %ERRORLEVEL% =====
endlocal
