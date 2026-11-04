@echo off
setlocal
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "DISTUTILS_USE_SDK=1"
set "TORCH_NVCC_FLAGS=-allow-unsupported-compiler"
cd /d "D:\4D\4d-gaussian-splatting"
echo ============================================================ >> "D:\4D\train_n3v_resume.log"
echo  RESUME START %DATE% %TIME%  (from chkpnt1250) >> "D:\4D\train_n3v_resume.log"
echo ============================================================ >> "D:\4D\train_n3v_resume.log"
"%CONDA_PREFIX%\python.exe" -u train.py --config configs/dynerf/n3v_fast.yaml --start_checkpoint output/N3V/hacknex_10s_fast/chkpnt1250.pth --save_iterations 1500 2000 2500 3000 4000 5000 6000 --test_iterations 999999 >> "D:\4D\train_n3v_resume.log" 2>&1
echo ===== TRAIN_N3V_RESUME EXIT: %ERRORLEVEL% %DATE% %TIME% ===== >> "D:\4D\train_n3v_resume.log"
endlocal
