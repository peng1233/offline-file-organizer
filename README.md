# 离线文件整理器（批量改名/打包ZIP）

English README: [README_EN.md](README_EN.md)

- 100% 本地运行（不上传、不联网）
- 批量选择文件 → 按规则改名 → 打包 ZIP 下载

## 使用
打开 `index.html` 即可。

如果你需要使用浏览器的“选择文件夹/目录”能力（File System Access API），建议用本仓库自带的本地服务器在 `http://localhost` 下打开（`file://` 方式在部分浏览器会被限制）：

```bash
node tools/serve.js
```

然后访问：
- 主版：`http://127.0.0.1:5173/`
- Lite：`http://127.0.0.1:5173/lite/`

## 完全离线版（Lite，推荐作为兜底）
如果你的环境无法加载第三方库/无法生成 ZIP，使用 Lite 版：
- 入口：`lite/index.html`
- 特点：不依赖外网与第三方库；支持批量改名、逐个下载、导出 CSV 清单；ZIP 打包为可选增强。

Lite 演示截图（支持“加载示例（无文件）”，便于快速理解/宣传）：

![Lite demo](docs/assets/lite-demo.png)

## 打赏支持（BTC）
收款页：https://peng1233.github.io/btc-receive/

> 说明：当前采用“金额归因（2B临时方案）”。如果需要精确对账到任务/角色，请让作者生成“专属金额订单”。
