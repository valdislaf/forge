@echo off
setlocal
rmdir /s /q vsbuild  2>nul

call "C:\Program Files (x86)\Intel\oneAPI\setvars.bat"

set "IFX=C:\Program Files (x86)\Intel\oneAPI\compiler\latest\bin\ifx.exe"
set "VCPKG=C:\vcpkg"

cmake -S . -B vsbuild -G "Visual Studio 17 2022" -A x64 ^
  -DCMAKE_Fortran_COMPILER:FILEPATH="%IFX%" ^
  -DCMAKE_TOOLCHAIN_FILE=%VCPKG%\scripts\buildsystems\vcpkg.cmake ^
  -DCMAKE_C_COMPILER=cl

cmake --build vsbuild --config Debug
echo.
echo [OK] Visual Studio solution: vsbuild\*.sln
pause
exit /b 0

