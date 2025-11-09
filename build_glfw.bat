@echo off
setlocal ENABLEDELAYEDEXPANSION

REM =========================================================
REM  Simple build script for Fortran + GLFW (MSYS2 MinGW-w64)
REM  - Auto-detects MINGW64 vs UCRT64
REM  - Cleans old *.mod and the EXE
REM  - Tries to link with -lglfw3, falls back to -lglfw
REM  - Copies needed runtime DLLs next to the EXE
REM  Usage:
REM     build_glfw.bat           -> build
REM     build_glfw.bat run       -> build and run
REM     build_glfw.bat clean     -> remove *.mod and EXE
REM =========================================================

REM --- Settings (adjust MSYS2 root if needed) ---
set "MSYS64=C:\msys64"

REM --- Auto-detect toolchain (UCRT64 preferred if present) ---
if exist "%MSYS64%\ucrt64\bin\gfortran.exe" (
  set "MINGW_BIN=%MSYS64%\ucrt64\bin"
  set "MINGW_LIB=%MSYS64%\ucrt64\lib"
) else (
  set "MINGW_BIN=%MSYS64%\mingw64\bin"
  set "MINGW_LIB=%MSYS64%\mingw64\lib"
)

REM --- Project files ---
set "SRC=forge.f90"
set "EXE=forge.exe"

REM --- Clean only? ---
if /I "%~1"=="clean" (
  echo [CLEAN] Removing *.mod and %EXE%
  del /Q /F *.mod 2>nul
  del /Q /F "%EXE%" 2>nul
  echo [DONE]
  goto :end
)

REM --- Ensure gfortran is visible in PATH for this session ---
set "PATH=%MINGW_BIN%;%PATH%"

REM --- Remove stale outputs before build ---
del /Q /F *.mod 2>nul
del /Q /F "%EXE%" 2>nul

echo:
echo === Compiling %SRC% ===
REM First try to link against -lglfw3
gfortran "%SRC%" -o "%EXE%" ^
  -L"%MINGW_LIB%" -lglfw3 -lopengl32 -lgdi32 -luser32 -lkernel32
if errorlevel 1 (
  echo [WARN] Failed to link with -lglfw3, trying -lglfw...
  gfortran "%SRC%" -o "%EXE%" ^
    -L"%MINGW_LIB%" -lglfw -lopengl32 -lgdi32 -luser32 -lkernel32
  if errorlevel 1 (
    echo [ERROR] Build failed.
    goto :end
  )
)

echo:
echo === Copying runtime DLLs next to the EXE ===
REM GLFW runtime DLL (name differs across packages)
if exist "%MINGW_BIN%\glfw3.dll" copy /Y "%MINGW_BIN%\glfw3.dll" . >nul
if exist "%MINGW_BIN%\glfw.dll"  copy /Y "%MINGW_BIN%\glfw.dll"  . >nul

REM Fortran/GCC runtimes (copy only if present)
for %%F in (libgfortran-*.dll libquadmath-0.dll libgcc_s_seh-1.dll libwinpthread-1.dll) do (
  if exist "%MINGW_BIN%\%%F" copy /Y "%MINGW_BIN%\%%F" . >nul
)

echo:
echo [DONE] Built %EXE%
echo If double-click fails, add to PATH: %MINGW_BIN%
echo:

REM --- Optional run ---
if /I "%~1"=="run" (
  echo === Running %EXE% ===
  "%EXE%"
)

:end
endlocal

forge.exe
pause