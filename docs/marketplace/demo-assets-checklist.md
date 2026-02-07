# 演示素材清单（Demo assets checklist）

目标：补齐 10–20 秒即可看懂的演示素材，用于 Upwork/Fiverr/Toptal/GitHub Sponsors 的服务页/提案/README。

录制工具（Windows）：docs/marketplace/how-to-record-gif-windows.md

## 1) 最小演示 GIF（10–15 秒）— Lite（完全离线）

**用途**：让用户 1 眼理解“批量改名→导出 CSV/复制 CSV→逐个下载（无第三方依赖）”。

**推荐录制窗口**：浏览器打开 `https://peng1233.github.io/offline-file-organizer/lite/`

**脚本（镜头顺序）**：
1. 点击 **Load demo**（无文件示例）
2. 点击 **Generate preview**（或同等按钮，生成改名预览）
3. 点击 **Copy CSV**（展示可复制清单；若降级为文本框也可以）
4. 可选：点击 **Export CSV**（下载）

**画面文字（可选叠字，1 行即可）**：
- “Offline • Privacy • Batch rename preview • Export/Copy CSV”

**输出文件名建议**：
- `docs/assets/lite-demo-rename-csv.gif`

**无需手动的兜底版本（已自动生成，可先用于投递/上架素材位）**：
- `docs/assets/lite-demo.gif`（由现有截图拼成动图，非真实录屏，但能快速说明功能流程）

## 2) 最小演示 GIF（10–15 秒）— 主版本（ZIP 可选增强）

**用途**：展示“同样离线使用 + 可选 ZIP 打包下载（若浏览器支持/依赖可用）”。

**推荐录制窗口**：`https://peng1233.github.io/offline-file-organizer/`

**脚本**：
1. 打开主页（显示入口：Main + Lite）
2. 简单展示：选择文件夹/文件 → 生成预览 → 下载

**输出文件名建议**：
- `docs/assets/main-demo-rename-download.gif`

## 3) 1 张静态截图（用于平台首屏）

**建议内容**：Lite 页面 + 预览表格 + “Copy CSV / Export CSV”按钮区域。

**输出文件名建议**：
- `docs/assets/lite-demo-hero.png`

## 4) 平台文案引用位置（把素材挂上去）

- `docs/marketplace/service-description*.md`：在开头加 1 行“Demo GIF/Screenshot”链接（指向仓库文件或 GitHub Pages）
- `docs/marketplace/README.md`：增加一节“Demo assets”（列出上述文件）

## 5) 录制建议（不强制）

- 尽量不要露出本地路径/隐私文件名；用 Lite 的 **Load demo** 最安全。
- 尺寸建议：宽 900–1200px；GIF 控制在 2–6MB（平台更友好）。
