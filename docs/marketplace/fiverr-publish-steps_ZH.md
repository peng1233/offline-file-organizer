# Fiverr 上架步骤（中文版，便于国内操作）

目标：在 Fiverr 上发布 1 个 Gig（服务），用于推广/交付 Offline File Organizer (Lite)。
本文件是“按步骤执行”的清单，并引用本目录里已准备好的英文文案/素材，避免临场临时写导致出错。

## 开始前（强烈建议）
- 先跑一次预检（应输出 PRECHECK_OK）：
  - powershell -NoProfile -ExecutionPolicy Bypass -File scripts/marketplace-preflight.ps1
- 确认演示素材存在（仓库内已准备）：
  - docs/assets/lite-demo.gif
  - docs/assets/lite-demo.png
  - docs/assets/lite-demo-real.png

## 1）创建 Gig
Fiverr 后台路径一般是：My Business -> Gigs -> Create a new Gig（不同时间 UI 可能有变化，以实际为准）。

## 2）Overview（标题/分类/标签）
- 标题（Title）：从 docs/marketplace/fiverr-titles-keywords_EN.md 里选 1 条
- 分类（Category/Subcategory）：优先选 Programming & Tech -> Software Development（或最接近的选项，按 Fiverr UI 调整）
- 搜索标签（Search tags）：从 docs/marketplace/fiverr-titles-keywords_EN.md 里挑 5 个

## 3）Scope & Pricing（套餐/交付周期）
- 套餐文案（Basic/Standard/Premium）：以 docs/marketplace/fiverr-packages-copy_EN.md 为准，直接复制粘贴
- 交付时间（Delivery time）：不要夸张，给自己留余量
- 如果 Fiverr 强制填写 Revisions / Number of files 等字段：
  - 填最小且清晰的值，避免承诺过多导致后续纠纷

## 4）Description（服务描述）
- 主描述：从 docs/marketplace/fiverr-gig-copy_EN.md 复制粘贴
- 可选：加上“纯文本链接”（不使用花哨符号，尽量减少被平台过滤/乱码风险）：
  - GitHub：https://github.com/peng1233/offline-file-organizer
  - 打赏（BTC）：https://peng1233.github.io/btc-receive/

## 5）FAQ（常见问题）
- 直接粘贴 docs/marketplace/fiverr-faq-copy_EN.md 的内容

## 6）Requirements（买家需要提供的信息）
只问交付必需的信息，越少越好：
- 操作系统（Windows 版本）
- 文件夹规模（大概多少文件/多大体积）
- 希望输出什么（整理后的文件夹结构 / 重命名 / CSV 报告）
- 是否有命名规则/分类规则需要遵循

## 7）Gallery（图片/GIF 素材）
上传：
- docs/assets/lite-demo.gif
- docs/assets/lite-demo.png
- docs/assets/lite-demo-real.png
如需要图片说明（caption），参考 docs/marketplace/fiverr-gallery-captions_EN.md。

## 8）发布（Publish）
- 最后检查：错别字、价格、交付周期是否合理
- 点击发布

## 发布后快速自检
- 用无痕窗口搜索自己的 Gig 标题，确认可见
- 检查描述第一行是否足够抓人
- 检查素材顺序：建议 GIF 放第一张
