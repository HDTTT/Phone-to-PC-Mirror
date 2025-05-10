# 手机投屏 + 声音回传一键脚本

> 本项目集成了 scrcpy 与 sndcpy，实现 Android 设备在 PC 上的低延迟画面投屏、键鼠操控与声音回传，并提供一键启动脚本，免去重复配置。

## 目录

- [功能简介](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#功能简介)
- [前置条件](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#前置条件)
- [文件结构](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#文件结构)
- [安装与配置](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#安装与配置)
- [使用说明](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#使用说明)
  - [一键启动脚本](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#一键启动脚本)
  - [常用快捷键](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#常用快捷键)
- [故障排查](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#故障排查)
- [自定义与维护](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#自定义与维护)
- [License](https://chatgpt.com/c/681e1a31-ba98-8009-88b8-04b160ae70ad#license)

## 功能简介

- **画面投屏**：通过 [scrcpy](https://github.com/Genymobile/scrcpy) 实时镜像 Android 屏幕，并可用鼠标键盘操控。
- **声音回传**：通过 [sndcpy](https://github.com/rom1v/sndcpy) 捕捉设备音频，借助 VLC 在 PC 上播放。
- **低延迟**：USB 连接下画面延迟一般在几十毫秒，音画高度同步。
- **一键启动**：脚本自动设置环境、启动投屏与音频回传，无需手动敲命令。

## 前置条件

1. Windows / macOS / Linux 任意一台 PC
2. Android 设备，已开启「开发者选项」->「USB 调试」
3. 安装或解压目录：
   - **Android SDK Platform-Tools**（包含 `adb`）
   - **scrcpy**（含 `scrcpy.exe/sh`）
   - **sndcpy**（含 `sndcpy.bat`、`sndcpy.apk`）
   - **VLC media player**（确保 `vlc.exe` 在可调用路径）

## 文件结构

```text
project-root/
├── platform-tools/        # Android SDK Platform-Tools
│	└──adb(.exe)		
├── scrcpy/                # scrcpy 可执行文件
│   └──scrcpy(.exe/.sh)		
├── sndcpy/                # sndcpy 脚本与 APK
│   ├── sndcpy.bat
│   ├── sndcpy
│   └── sndcpy.apk
└── start_cast.bat         # 一键启动脚本
```

## 安装与配置

1. **解压/安装工具包**

   - `platform-tools`、`scrcpy`、`sndcpy`、`VLC` 各自放入项目目录。

2. **修改一键脚本**

   - 打开 `start_cast.bat`，根据实际目录调整 `set PATH=...` 中的路径。

   - 如有必要，修改 `sndcpy.bat` 内 VLC 路径变量：

     ```bat
     if not defined VLC set VLC="D:\...\VLC\vlc.exe"
     ```

## 使用说明

### 一键启动脚本

双击 `start_cast.bat` 即可：

1. 临时将所需目录加入环境变量 `PATH`
2. 并行启动 scrcpy：保持设备常亮或息屏（根据参数）
3. 启动 sndcpy：推送 APK、授权后开启 VLC 播放音频

脚本示例：

```bat
@echo off
set PATH=D:\...\VLC;D:\...\platform-tools;D:\...\scrcpy;D:\...\sndcpy;%PATH%
start "" scrcpy --stay-awake --turn-screen-off
timeout /t 2 >nul
start "" sndcpy.bat
exit /b
```

### 常用快捷键

| 功能             | 快捷键                 |
| ---------------- | ---------------------- |
| 全屏/退出全屏    | `MOD` + `f`            |
| Home             | `MOD` + `h` / 中键单击 |
| Back             | `MOD` + `b` / 右键单击 |
| 多任务           | `MOD` + `s`            |
| 关闭屏幕（息屏） | `MOD` + `o`            |
| 打开屏幕         | `MOD` + `Shift` + `o`  |
| 菜单/解锁        | `MOD` + `m`            |
| 音量+/音量−      | `MOD` + ↑/↓            |
| 电源键           | `MOD` + `p`            |
| 输出 FPS         | `MOD` + `i`            |

> `MOD` 默认是左 `Alt` 或左 `Super`。

## 故障排查

- **sndcpy 无法启动 VLC**：
  - 确保脚本中 `VLC` 路径指向正确的 `vlc.exe`
  - 或将 VLC 目录临时加入脚本环境变量 `PATH`
- **scrcpy 连接失败**：
  - 检查 USB 调试是否已授权，执行 `adb devices`
  - 重启 adb：`adb kill-server && adb start-server`
- **快捷键无效**：
  - 确认 scrcpy 版本是否支持对应快捷
  - 可用 `scrcpy --help` 查看本地快捷详情

## 自定义与维护

- **更新 sndcpy**：

  - 下载新版 APK，替换 `sndcpy.apk` 文件即可。脚本会自动覆盖安装。

- **调整脚本参数**：

  - scrcpy 可追加码率、分辨率限制、录制等参数：

    ```bat
    scrcpy --bit-rate 4M --max-size 1024 --record file.mp4
    ```

- **定期清理**：

  - 如不再使用，卸载手机上的 `com.rom1v.sndcpy` 应用：

    ```bash
    
    ```

adb uninstall com.rom1v.sndcpy
 \```

## License

MIT © Your Name