@echo off
setlocal
if "%~1"=="" (
    echo usage: run.bat ^<script.py^> [args...]
    exit /b 2
)

set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44
if errorlevel 1 (
    echo [run] vcvarsall failed
    exit /b 1
)

set "DISTUTILS_USE_SDK=1"
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.6"
set "CUDA_PATH=%CUDA_HOME%"

set "REPO=C:\Users\SANJAY V S\Documents\4D\4d-gaussian-splatting"
set "PYTHONPATH=%REPO%;%REPO%\simple-knn;%REPO%\pointops2;%PYTHONPATH%"

set "TARGET=%~1"
shift
set "ARGS="
:collect
if "%~1"=="" goto run
set ARGS=%ARGS% %1
shift
goto collect
:run
"%CONDA_PREFIX%\python.exe" "%TARGET%"%ARGS%
exit /b %ERRORLEVEL%
