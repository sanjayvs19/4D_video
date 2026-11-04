@echo off
setlocal
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "CB=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting\Library\bin"
echo ===== colmap.exe direct dependents =====
dumpbin /dependents "%CB%\colmap.exe"
endlocal
