@echo off
:: -------------------------------
:: 一键启动 scrcpy + sndcpy（动态获取脚本目录）
:: -------------------------------

:: 获取脚本自身所在目录（末尾带反斜杠）
set "BASEDIR=%~dp0"

:: 预定义工具路径
set "ADB=%BASEDIR%platform-tools\adb.exe"
set "VLC=%BASEDIR%VLC\vlc.exe"
set "SNDCPY_APK=%BASEDIR%sndcpy\sndcpy.apk"

:: 临时把工具目录加入 PATH
:: （假设你在 BASEDIR 下有 VLC\, platform-tools\, scrcpy\, sndcpy\ 这四个子文件夹）
set "PATH=%BASEDIR%VLC;%BASEDIR%platform-tools;%BASEDIR%scrcpy;%BASEDIR%sndcpy;%PATH%"


:: 2. 启动 scrcpy：保持设备常亮，且把屏幕关掉（节省电）
start "" scrcpy --stay-awake --turn-screen-off

:: 等待 scrcpy 完全启动
timeout /t 2 /nobreak >nul


exit /b 0
