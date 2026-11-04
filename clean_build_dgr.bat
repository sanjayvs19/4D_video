@echo off
setlocal
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "DISTUTILS_USE_SDK=1"
set "TORCH_NVCC_FLAGS=-allow-unsupported-compiler"
echo ===== which cl / version =====
where cl
cl 2>&1 | findstr /C:"Version"
echo ===== clearing JIT cache =====
rmdir /s /q "%LOCALAPPDATA%\torch_extensions\torch_extensions\Cache\py37_cu116\diff_gaussian_rasterization" 2>nul
cd /d "D:\4D\4d-gaussian-splatting"
echo ===== compiling rasterizer via JIT =====
"%CONDA_PREFIX%\python.exe" -c "import importlib.util as u; s=u.spec_from_file_location('dgr','gaussian_renderer/diff_gaussian_rasterization.py'); m=u.module_from_spec(s); s.loader.exec_module(m); print('DGR OK', hasattr(m._C,'rasterize_gaussians'))"
echo ===== DGR BUILD EXIT: %ERRORLEVEL% =====
endlocal
