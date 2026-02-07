# 离线文件整理器（批量改名/打包ZIP）

English README: [README_EN.md](README_EN.md)

- 100% 本地运行（不上传、不联网）
- 批量选择文件 → 按规则改名 → 打包 ZIP 下载

## 使用
打开 `index.html` 即可。

Windows：也可以直接双击 `open.cmd` 打开主版（注意：部分浏览器在 `file://` 下会限制“选择文件夹/目录”能力，遇到限制请改用下面的 localhost 方式）。

如果你需要使用浏览器的“选择文件夹/目录”能力（File System Access API），建议用本仓库自带的本地服务器在 `http://localhost` 下打开（`file://` 方式在部分浏览器会被限制）：

```bash
node tools/serve.js
```

Windows 一键启动（PowerShell 脚本）：`docs/windows-quickstart.md`

然后访问：
- 主版：`http://127.0.0.1:5173/`
- Lite：`http://127.0.0.1:5173/lite/`

## 完全离线版（Lite，推荐作为兜底）
如果你的环境无法加载第三方库/无法生成 ZIP，使用 Lite 版：
- 入口：`lite/index.html`
- 特点：不依赖外网与第三方库；支持批量改名、逐个下载、导出 CSV 清单；ZIP 打包为可选增强。

Lite 演示截图（支持“加载示例（无文件）”，便于快速理解/宣传）：

![Lite demo](docs/assets/lite-demo.png)

## 变现（Fiverr / Upwork / Toptal / GitHub Sponsors）
如果你想把这个工具的能力做成可交付服务（例如：帮客户批量改名/整理文件并交付 ZIP + 清单），这里有一些可直接复用的文案模板（可直接复制粘贴到平台）：
- Fiverr Gig 模板：`docs/monetization/fiverr-gig-template.md`
- Fiverr Gig 文案（英文可直接复制）：`docs/marketplace/fiverr-gig-copy_EN.md`
- Fiverr/Upwork 服务包（定价 + 交付物清单）：`docs/monetization/service-packages_Fiverr_Upwork.md`
- GitHub Sponsors 开通/填写清单：`docs/monetization/github-sponsors-checklist.md`
- Upwork Proposal 模板（长版）：`docs/monetization/upwork-proposal-template.md`
- Upwork Proposal 模板（短版/英文 300~600 词）：`docs/monetization/upwork-proposal-template-short_EN.md`
- Upwork Proposal 模板（迷你版/英文 150~250 词）：`docs/monetization/upwork-proposal-template-mini_EN.md`
- 平台服务介绍（完整版/中文）：`docs/marketplace/service-description.md`
- 平台服务介绍（短版/中英）：`docs/marketplace/service-description-short.md` / `docs/marketplace/service-description-short_EN.md`
- 一页式介绍（短版/中英）：`docs/marketplace/one-pager-short.md` / `docs/marketplace/one-pager-short_EN.md`
- 一页式介绍（长版/中英）：`docs/marketplace/one-pager.md` / `docs/marketplace/one-pager_EN.md`
- 服务介绍变体合集（A/B 测试/中文）：`docs/marketplace/service-description-variants.md`
- 演示素材清单（截图/动图待办）：`docs/marketplace/demo-assets-checklist.md`
- 项目范围/验收标准/风险/回滚（一页式模板，中英）：`docs/marketplace/project-scope-template.md`

（白名单平台：Upwork/Fiverr/Toptal/GitHub Sponsors）

## GitHub Sponsors
如果这个工具帮你省了时间（或让你更快交付自由职业项目），欢迎在这里支持后续维护：
- https://github.com/sponsors/peng1233

## 打赏支持（BTC）
收款页：https://peng1233.github.io/btc-receive/

> 说明：当前采用“金额归因（2B临时方案）”。如果需要精确对账到任务/角色，请让作者生成“专属金额订单”。
