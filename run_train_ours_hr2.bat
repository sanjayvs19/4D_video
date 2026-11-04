@echo off
setlocal
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "DISTUTILS_USE_SDK=1"
set "TORCH_NVCC_FLAGS=-allow-unsupported-compiler"
cd /d "D:\4D\4d-gaussian-splatting"
"%CONDA_PREFIX%\python.exe" train.py --config configs/dynerf/ours_hr.yaml --start_checkpoint output/ours/hacknex_hr/chkpnt1500.pth --save_iterations 1700 1900 2100 2300 2500 2700 2900 3000 --test_iterations 3000 > "D:\4D\train_ours_hr2.log" 2>&1
echo ===== TRAIN_HR2 EXIT: %ERRORLEVEL% ===== >> "D:\4D\train_ours_hr2.log"
endlocal
