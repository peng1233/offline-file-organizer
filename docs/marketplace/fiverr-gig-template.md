# Fiverr Gig 模板（Offline File Organizer 相关）

> 目的：提供一个**可直接复制粘贴**的 Fiverr Gig 页面结构（标题/副标题/描述/FAQ/需求收集/交付物/验收标准）。
> 
> 说明：不包含任何账号信息/收款信息/价格承诺；你可以按平台限制自行裁剪。

---

## 中文（可直接用）

### Gig 标题（选 1）
1) 我会为你定制一个完全离线的批量改名/导出清单小工具（隐私合规）
2) 我会把你的文件批量重命名流程自动化（离线网页工具 + 清单 CSV）
3) 我会交付一个可离线运行的文件整理工具：批量改名 + 清单导出

### 副标题/一句话（选 1）
- 不上传文件，不联网，直接在浏览器本地处理；交付可回滚
- 30 秒上手：选择文件夹/文件 → 预览改名 → 下载/导出清单

### 描述（建议 8~12 行）
你是不是经常遇到：
- 文件名乱、需要批量改名但不想装软件
- 客户/团队需要“改名清单”作为交付证据（CSV/TSV）
- 不能上传文件（隐私/合规/内网环境）

我会为你交付一个**完全离线**的小工具（网页/脚本），实现：
- 批量生成新文件名（前缀+序号 / 保留原名+前缀 / 查找替换）
- 预览与冲突检测（避免重名覆盖）
- 导出改名清单（CSV/TSV，便于对账/归档）
- 可选：ZIP 下载（在允许的环境中启用）

你只需要告诉我你的命名规则与样例（**不需要发真实文件**）。

### 我需要你提供什么（Requirements）
- 你想要的命名规则（例子越具体越好）
- 3~10 个“原始文件名 → 期望新文件名”的样例（可以是虚拟示例）
- 是否需要导出 CSV/TSV（以及列名偏好）
- 你的目标环境：Windows/macOS；Chrome/Edge；是否只能离线 file:// 打开

### 交付物（Deliverables）
- 可离线运行的工具（HTML/JS 或脚本）
- 一份简短使用说明（README）
- 一份自检结果/验收清单（确保可复现）

### 验收标准（Acceptance）
- 用你提供的样例输入，生成的输出与预期一致
- 不联网可用（页面不请求外部资源）
- 明确的回滚方式（不改你的原始文件，只生成新文件/清单）

### FAQ（可选）
Q: 你会看到/拿到我的文件吗？
A: 不需要。我们用“文件名样例”即可；工具在你的浏览器本地运行。

Q: 能处理上千个文件吗？
A: 可以，但受浏览器内存与下载策略影响。我会给出最稳妥的离线方案与限制说明。

Q: 能做成 ZIP 一次下载吗？
A: 可以（可选），但 ZIP 依赖第三方库；如果你的环境不允许，我会提供逐个下载的离线兜底。

---

## English (copy-ready)

### Gig title (pick 1)
1) I will deliver a fully-offline bulk rename tool with CSV/TSV manifest export
2) I will automate your file renaming workflow (offline web tool + manifest)
3) I will customize a privacy-friendly offline file organizer for bulk renaming

### One-liner (pick 1)
- No upload. No cloud. Everything runs locally in your browser.
- 30-second workflow: select files → preview → download / export manifest.

### Description (8-12 lines)
If you need bulk renaming but:
- you don’t want to install apps,
- you can’t upload files due to privacy/compliance,
- you need an auditable rename manifest for delivery (CSV/TSV),

I can deliver a **fully-offline** tool that:
- generates new filenames in bulk (prefix+index / keepname+prefix / search&replace)
- previews and detects collisions (prevents duplicates)
- exports a rename manifest (CSV/TSV) for review/audit
- optionally supports ZIP download (when allowed)

You only need to provide naming rules + examples (no real files required).

### Requirements
- Your naming rules
- 3-10 examples: “old name → expected new name” (mock examples are fine)
- Whether you need CSV/TSV export (and column name preference)
- Target environment: Windows/macOS, Chrome/Edge, offline-only (file://) constraints

### Deliverables
- Offline runnable tool (HTML/JS or scripts)
- Short README (how to run + limitations)
- Self-check / acceptance checklist

### Acceptance
- With your sample inputs, output matches expected
- Works offline (no external requests)
- Rollback-friendly: does not modify your original files
