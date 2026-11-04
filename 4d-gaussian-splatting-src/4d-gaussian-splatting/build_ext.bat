@echo off
setlocal
if "%~1"=="" (
    echo usage: build_ext.bat ^<extension_dir^>
    exit /b 2
)

set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44
if errorlevel 1 (
    echo [build_ext] vcvarsall failed
    exit /b 1
)

set "DISTUTILS_USE_SDK=1"
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.6"
set "CUDA_PATH=%CUDA_HOME%"

echo [build_ext] directory : %~1
cl 2>&1 | findstr /i "Compiler Version"
nvcc --version | findstr /i "release"

pushd "%~1"
"%CONDA_PREFIX%\python.exe" setup.py build_ext --inplace -v
set "RC=%ERRORLEVEL%"
popd
exit /b %RC%
