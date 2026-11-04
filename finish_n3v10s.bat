@echo off
setlocal
set "CONDA_PREFIX=C:\Users\SANJAY V S\miniconda3\envs\4d_gaussian_splatting"
set "PATH=%CONDA_PREFIX%;%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%CONDA_PREFIX%\Library\mingw-w64\bin;%CONDA_PREFIX%\Scripts;%PATH%"
set "VSROOT=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.44 1>nul
set "DISTUTILS_USE_SDK=1"
set "TORCH_NVCC_FLAGS=-allow-unsupported-compiler"
cd /d "D:\4D\4d-gaussian-splatting"
set "CKPT=output\N3V\hacknex_10s_fast\chkpnt6000.pth"

echo ============================================================ >> "D:\4D\finish_n3v10s.log"
echo  FINISH PIPELINE START %DATE% %TIME% >> "D:\4D\finish_n3v10s.log"
echo ============================================================ >> "D:\4D\finish_n3v10s.log"

:wait
if exist "%CKPT%" goto go
timeout /t 60 /nobreak >nul
goto wait

:go
echo waiting done, ckpt found %DATE% %TIME% >> "D:\4D\finish_n3v10s.log"
echo ---- encode ---- >> "D:\4D\finish_n3v10s.log"
"%CONDA_PREFIX%\python.exe" fourdv_encode.py %CKPT% D:\4D\hacknex_10s_final_raw.4dv --source data/N3V/hacknex_10s --time_start 0 --time_end 9.9 --opacity_thresh 0.03 --dist_prune 30 --max_radius 2.0 >> "D:\4D\finish_n3v10s.log" 2>&1
echo ---- rotate upright (rx -90) ---- >> "D:\4D\finish_n3v10s.log"
"%CONDA_PREFIX%\python.exe" rotate_4dv.py D:\4D\hacknex_10s_final_raw.4dv D:\4D\hacknex_10s_final.4dv --rx -90 >> "D:\4D\finish_n3v10s.log" 2>&1
echo ---- verify ---- >> "D:\4D\finish_n3v10s.log"
"%CONDA_PREFIX%\python.exe" verify_4dv.py D:\4D\hacknex_10s_final.4dv >> "D:\4D\finish_n3v10s.log" 2>&1
echo ---- check_match ---- >> "D:\4D\finish_n3v10s.log"
"%CONDA_PREFIX%\python.exe" check_match.py D:\4D\hacknex_10s_final.4dv >> "D:\4D\finish_n3v10s.log" 2>&1
echo ---- deploy ---- >> "D:\4D\finish_n3v10s.log"
copy /Y D:\4D\hacknex_10s_final.4dv D:\4D\deliverables\hacknex_10s_final.4dv >> "D:\4D\finish_n3v10s.log"
copy /Y D:\4D\hacknex_10s_final.4dv D:\4D\4d-gaussian-splatting\hacknex_10s_final.4dv >> "D:\4D\finish_n3v10s.log"
echo ============================================================ >> "D:\4D\finish_n3v10s.log"
echo  FINISH PIPELINE DONE %DATE% %TIME% >> "D:\4D\finish_n3v10s.log"
echo ============================================================ >> "D:\4D\finish_n3v10s.log"
endlocal