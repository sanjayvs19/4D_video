@echo off
REM ============================================================
REM  4D Gaussian Splatting environment launcher
REM  Usage: double-click or run  env_4dgs.bat  from this folder.
REM  It configures the conda env (without `conda activate`),
REM  forces MSVC 14.44 for CUDA 11.6, then drops you into a
REM  ready-to-use shell. Then run e.g.:
REM     python train.py --config configs/dynerf/sear_steak.yaml
REM ============================================================
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "DISTUTILS_USE_SDK=1"
REM Make the rasterizer JIT build (and any extension rebuild) use the override too:
set "TORCH_NVCC_FLAGS=-allow-unsupported-compiler"
cd /d "C:\Users\SANJAY V S\Documents\4D\4d-gaussian-splatting"
echo [4DGS] Environment ready.  python = %CONDA_PREFIX%\python.exe
echo [4DGS] cl / nvcc:
cl 2>&1 | findstr /C:"Version"
nvcc --version | findstr /C:"release"
echo.
cmd /k "%CONDA_PREFIX%\python.exe -c ""import torch;print('torch',torch.__version__,'cuda',torch.version.cuda,'gpu',torch.cuda.is_available())"""
