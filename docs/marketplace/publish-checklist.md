# 发布/投递检查清单（Upwork / Fiverr / Toptal / GitHub Sponsors）

> 目的：把仓库里已有的文案/素材/演示入口，快速拼成一个“可发布的服务页/Proposal”，并减少反复改稿。
>
> 约束：不包含任何账号信息/收款私钥/敏感信息；最终上架/投递/提交仍需人工确认。

## 0) 先选一个“主卖点”

三选一（建议先选 1 个）：

- **隐私/合规**：完全离线、本地运行，不上传文件；适合敏感资料。
- **效率/交付**：批量重命名 + 导出/复制 CSV 清单 + 下载（逐个/ZIP 可选）。
- **Windows 友好**：一键启动 localhost（解决部分浏览器 file:// 受限）。

## 1) 必放链接（对外可用）

- GitHub 仓库：<https://github.com/peng1233/offline-file-organizer>
- 在线演示（主页面）：<https://peng1233.github.io/offline-file-organizer/>
- 在线演示（Lite，完全离线兜底）：<https://peng1233.github.io/offline-file-organizer/lite/>
- 打赏页（BTC）：<https://peng1233.github.io/btc-receive/>

## 2) 可直接复制粘贴的文案入口（仓库内）

- 服务描述（主版本）：`docs/marketplace/service-description.md`
- 服务描述 Variant B：`docs/marketplace/service-description-variant-b.md`
- A/B 短文案：`docs/marketplace/service-description-variants.md`
- 个人简介模板（100~200 词/字）：`docs/marketplace/platform-profile-template.md`
- 项目范围/验收/风险/回滚模板：`docs/marketplace/project-scope-template.md`

## 3) 演示素材（截图/GIF）最低配置

最低 1 张图（或 1 段 GIF）说明 “你能做什么”。建议按清单准备：

- `docs/marketplace/demo-assets-checklist.md`

推荐 10–20 秒 GIF 脚本（Lite 演示模式即可）：

1. 打开 Lite 页面
2. 点击 **Load demo**（加载示例，无需真实文件）
3. 生成改名方案（预览）
4. 点击 **Copy CSV**（展示可复制清单）

## 4) Upwork（Proposal）结构模板

建议按 6 段（短、硬）：

1) 你要的结果（1 句）
2) 我怎么做（3 条 bullet）
3) 验收标准（引用 `project-scope-template.md` 的 3~5 条）
4) 时间与交付物（不报具体价格也行）
5) 风险与回滚（强调“不改原文件/可回滚”）
6) 演示链接 + 截图

## 5) Fiverr（Gig）结构模板

- 标题：强调“Offline / Batch rename / CSV manifest”
- 描述：直接用 `service-description-variants.md` 的短文
- FAQ：复制 `project-scope-template.md` 的常见问题（精简）
- Gallery：至少 1 张截图（建议用 Lite demo 图）

## 6) Toptal（申请/沟通）注意点

- 强调：**Offline / privacy-first / no cloud upload**
- 用英文模板：`README_EN.md` + `docs/windows-quickstart-en.md`
- 面试沟通：准备 1 分钟“为什么离线更稳”的说明（可复用 en.html 文案）

## 7) GitHub Sponsors（仓库内可做的事）

- README 里保持：演示入口 + 价值点 + 使用步骤 + 支持入口（打赏页/赞助）
- 把文案与素材都放在仓库 `docs/marketplace/`，方便复用。

---

## 最后检查（发布前 30 秒）

- [ ] 文字无乱码（UTF-8）
- [ ] 链接可打开（Pages 已部署）
- [ ] 没有任何密钥/账号信息/个人隐私泄露
- [ ] 承诺可交付、可验收、可回滚
