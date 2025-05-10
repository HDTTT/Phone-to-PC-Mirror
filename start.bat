@echo off
:: 一键启动 scrcpy + sndcpy

:: 1. 把所有工具目录临时加入 PATH
set PATH=D:\SmallTool\phone_share_to_PC\VLC;D:\SmallTool\phone_share_to_PC\platform-tools\platform-tools;D:\SmallTool\phone_share_to_PC\scrcpy\scrcpy-win64-v3.2;D:\SmallTool\phone_share_to_PC\sndcpy;%PATH%

:: 2. 启动 scrcpy：保持设备常亮，且把屏幕关掉（节省电）
start "" scrcpy --stay-awake --turn-screen-off

:: 等待 scrcpy 完全启动
timeout /t 2 /nobreak >nul

:: 3. 启动 sndcpy（听声音）
start "" sndcpy.bat

exit /b 0
