@echo off
setlocal
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "DISTUTILS_USE_SDK=1"
set "TORCH_NVCC_FLAGS=-allow-unsupported-compiler"
set "DGR_LINEINFO=1"
set "CUDA_LAUNCH_BLOCKING=1"
cd /d "D:\4D\4d-gaussian-splatting"
echo ===== clearing cache + compiling with lineinfo =====
rmdir /s /q "%LOCALAPPDATA%\torch_extensions\torch_extensions\Cache\py37_cu116\diff_gaussian_rasterization" 2>nul
"%CONDA_PREFIX%\python.exe" debug_render.py 1>nul 2>nul
echo ===== running compute-sanitizer memcheck =====
call "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.6\bin\compute-sanitizer.bat" --tool memcheck --error-exitcode 0 "%CONDA_PREFIX%\python.exe" debug_render.py
echo ===== SANITIZER DONE =====
endlocal
