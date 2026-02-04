# Offline File Organizer（离线文件整理器）

一个**完全离线**的浏览器小工具：批量选择文件 → 按规则生成新文件名 → 批量下载（默认逐个下载；可选 ZIP 打包）。

- 隐私：不上传、不联网（页面本身不请求任何网络资源）
- 运行：直接双击打开 `index.html`

## 功能
- 模式：
  - 前缀+序号（prefix-index）
  - 保留原名+前缀（keepname-prefix）
  - 替换（replace）
- 文件名安全处理：兼容 Windows/常见文件系统非法字符、尾部点/空格
- 冲突检测：提示重复文件名（下载/ZIP 前可二次确认）
- 导出清单：生成 `rename-manifest.csv`（便于留档/交付）
- 示例模式：一键加载示例文件名（用于演示/截图；仅预览/导出，不支持下载）

## 下载说明
- **默认：逐个下载**（无需第三方库，真正离线即可用）
- **可选：ZIP 打包**：把 `vendor/jszip.min.js` 放到同目录并在页面中启用即可

## 演示截图

![Lite 演示模式：批量改名预览 + 导出 CSV](../docs/assets/lite-demo.png)

- 在线演示（Lite）：https://peng1233.github.io/offline-file-organizer/lite/

## 说明文档
- 中文：README.md（本文件）
- English: README_EN.md

## 发布入口
- GitHub： https://github.com/peng1233/offline-file-organizer
- 打赏页（BTC）： https://peng1233.github.io/btc-receive/
- 注：页面底部也内置上述链接，便于离线分发后快速回到发布/支持入口。
