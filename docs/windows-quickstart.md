# Windows 快速启动（本地服务器）

> 适用场景：当你需要在浏览器里使用“选择目录/文件夹”（File System Access API）等能力时，建议通过 `http://localhost` 打开，而不是用 `file://` 直接双击打开。

## 先看这里：只想一键打开 Lite？（无需 Node.js）

如果你只是想快速打开 Lite 版页面预览/试用：

- 直接双击 `lite\\open.cmd`

注意：`file://` 打开时，部分浏览器能力可能受限（尤其是“选择文件夹/目录”相关）。需要完整能力请按本文启动本地服务器。

（示意截图：Lite 页面）

![Lite UI](assets/lite-ui.png)

## 前置条件

- 已安装 Node.js（建议 LTS 版本）

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

## 常见问题 / Troubleshooting

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
