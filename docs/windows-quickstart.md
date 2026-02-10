# Windows 快速启动（本地服务器）

> 适用场景：当你需要在浏览器里使用“选择目录/文件夹”（File System Access API）等能力时，建议通过 `http://localhost` 打开，而不是用 `file://` 直接双击打开。

## 先看这里：只想一键打开？（无需 Node.js）

如果你只是想快速预览/试用页面（通过 `file://` 方式打开）：

- 打开 **主版本**：直接双击仓库根目录的 `open.cmd`
- 打开 **Lite 版本**：直接双击 `lite\\open.cmd`

> 说明：`open.ps1`/`lite\\open.ps1` 是对应的 PowerShell 版本（便于高级用户改参数/排错），但一般双击 `.cmd` 就够了。
>
> 高级用法：如果你想打开特定的 Lite 文件（例如你改了 `lite\index.html` 的路径），可以用：
>
> ```powershell
> powershell -NoProfile -ExecutionPolicy Bypass -File .\lite\open.ps1 -Path .\lite\index.html
> ```

注意：`file://` 打开时，部分浏览器能力可能受限（尤其是“选择文件夹/目录”相关）。需要完整能力请按本文启动本地服务器。

（示意截图：Lite 页面）

![Lite UI](assets/lite-ui.png)

## 前置条件

- **推荐**：已安装 Node.js（建议 LTS 版本），启动更稳、兼容更多功能。
- **不装也能用**：`tools\serve.ps1` 会优先用 Node.js；如果系统没有 Node.js，会自动回退到 Python 的 `http.server`（前提是已安装 Python）。

## 一键启动（PowerShell）

在仓库根目录打开 PowerShell，然后运行：

```powershell
powershell -ExecutionPolicy Bypass -File tools\serve.ps1
```

- 主版本：http://127.0.0.1:5173/
- Lite：http://127.0.0.1:5173/lite/

## 自定义端口 / 不自动打开浏览器

```powershell
powershell -ExecutionPolicy Bypass -File tools\serve.ps1 -Port 5173 -NoOpen
```

## 打包一个可分享的 Lite ZIP（可直接发给客户/同事）

在仓库根目录打开 PowerShell，运行：

```powershell
powershell -ExecutionPolicy Bypass -File scripts\build-lite-release.ps1
```

产物位置：
- `lite\dist\offline-file-organizer-lite.zip`
- `lite\dist\RELEASE.txt`（包含 SHA256 与文件清单）

> 说明：该脚本会先执行 `lite\selfcheck.js`，确保打包前基本功能自检通过。

## 常见问题 / Troubleshooting

- 控制台中文乱码/日志看不清：
  - 用仓库自带脚本以 UTF-8 方式打印文件内容：

    ```powershell
    powershell -ExecutionPolicy Bypass -File scripts\print-utf8.ps1 -Path docs\windows-quickstart.md -Tail 80
    ```

- PowerShell 提示脚本被阻止/执行策略限制：
  - 推荐：用本文给出的命令（已带 `-ExecutionPolicy Bypass`），仅对当前次运行生效。
  - 或者只对当前 PowerShell 进程生效：

    ```powershell
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    ```

- 端口被占用（例如 5173 已在使用）：

  ```powershell
  powershell -ExecutionPolicy Bypass -File tools\serve.ps1 -Port 5174
  ```

- 只想离线预览 Lite（不需要“选择文件夹/目录”能力）：
  - 直接双击 `lite\\open.cmd` 即可。

## 停止

在运行窗口按 `Ctrl + C`。
