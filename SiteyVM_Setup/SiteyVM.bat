@echo off

set "BASE_DIR=%~dp0"
set "PYTHON_EXE=%BASE_DIR%python\python.exe"
set "PYTHONW_EXE=%BASE_DIR%python\pythonw.exe"
set "LAUNCHER=%BASE_DIR%launcher.py"

if not exist "%PYTHON_EXE%" (
    echo [HATA] Python bulunamadi: %PYTHON_EXE%
    pause
    exit /b 1
)

if not exist "%LAUNCHER%" (
    echo [HATA] launcher.py bulunamadi: %LAUNCHER%
    pause
    exit /b 1
)

set "SITEYVM_DATA_DIR=%LOCALAPPDATA%\SiteyVM"
if not exist "%SITEYVM_DATA_DIR%" mkdir "%SITEYVM_DATA_DIR%"

cd /d "%BASE_DIR%"

set "PYTHONPATH=%BASE_DIR%app\backend;%BASE_DIR%app"
set "PYTHONIOENCODING=utf-8"

set "CONFIG_FILE=%SITEYVM_DATA_DIR%\siteyvm_config.json"

REM Kurulum tamamlanmis mi kontrol et
if exist "%CONFIG_FILE%" (
    if exist "%BASE_DIR%python\Lib\site-packages\uvicorn\__init__.py" (
        if exist "%PYTHONW_EXE%" (
            REM Kurulum tamam - arka planda sessizce baslat (CMD penceresi SIFIR)
            start "" /b "%PYTHONW_EXE%" "%LAUNCHER%" --background
            exit /b 0
        )
    )
)

REM Ilk kurulum: bagimliliklari kur, sihirbazi calistir
echo.
echo   ============================================
echo     SITEY-VM Kurulum Baslatiliyor
echo   ============================================
echo.
echo   Bu pencere kurulum tamamlaninca kapanacak.
echo.

"%PYTHON_EXE%" "%LAUNCHER%" %*
