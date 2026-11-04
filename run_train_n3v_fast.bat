@echo off
setlocal
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "DISTUTILS_USE_SDK=1"
set "TORCH_NVCC_FLAGS=-allow-unsupported-compiler"
cd /d "D:\4D\4d-gaussian-splatting"
"%CONDA_PREFIX%\python.exe" train.py --config configs/dynerf/n3v_fast.yaml --save_iterations 200 400 600 800 1000 1250 1500 2000 2500 3000 4000 5000 --test_iterations 999999 > "D:\4D\train_n3v_fast.log" 2>&1
echo ===== TRAIN_N3V_FAST EXIT: %ERRORLEVEL% ===== >> "D:\4D\train_n3v_fast.log"
endlocal
