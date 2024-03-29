@echo off
setlocal enabledelayedexpansion

title ARP 검색

REM 입력으로 받은 IP 대역
echo.
set /p "ip_range=IP 대역 (예: 192.168.0.1) : "
echo.
REM IP주소 앞 3개 추출
for /f "tokens=1-3 delims=." %%a in ("%ip_range%") do (
    set "ip_range=%%a.%%b.%%c."
)
set /p "start_ip=시작 IP (최소1) : "
echo.
set /p "end_ip=종료 IP (최대254) : "
echo.


REM IP 대역으로부터 1부터 254까지의 각 IP에 대해 ARP 요청을 보냄
for /L %%i in (%start_ip%,1,%end_ip%) do (
    set "ip=!ip_range!%%i"
    arp -a | findstr /i !ip! > nul
    if errorlevel 1 (
        echo IP !ip! : 오프라인
    ) else (
        echo IP !ip! : 온라인
    )
)

echo.
pause
