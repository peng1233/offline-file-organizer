# 平台演示素材清单（可复制/可勾选）

> 目的：把“上架需要的素材”变成一个可执行清单，避免临场到 Upwork/Fiverr/Toptal 时反复找图/找链接。
> 
> 使用方法：
> - 先在本文件勾选已准备项；
> - 平台填写时，直接复制对应的 raw 直链（图片）或仓库链接（文案/步骤）。

## 1) 关键入口（复制粘贴用）

- GitHub 仓库：https://github.com/peng1233/offline-file-organizer
- 在线演示（主页）：https://peng1233.github.io/offline-file-organizer/
- 在线演示（Lite）：https://peng1233.github.io/offline-file-organizer/lite/
- 打赏页（BTC）：https://peng1233.github.io/btc-receive/

## 2) Fiverr/Upwork 通用素材（最少一套就能上架）

- [ ] 封面图（Cover）
  - 建议标题："Offline File Organizer" / "Batch rename + CSV + ZIP"
  - raw 直链：
    - https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/fiverr-cover.png

- [ ] 功能截图（Lite 演示）
  - 建议标题："Lite demo (no files needed)"
  - raw 直链：
    - https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/lite-demo.png

- [ ]（可选）真实流程截图（如果已有）
  - 用途：展示“导出清单/复制 CSV/逐个下载”的真实操作
  - raw 直链（若文件存在）：
    - https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/lite-demo-real.png

## 3) 文案/步骤（上架时直接照抄）

- [ ] Fiverr / Upwork 服务描述（多版本 A/B/C）
  - 目录：docs/marketplace/
  - 推荐入口：
    - docs/marketplace/service-description.md
    - docs/marketplace/service-description-variants.md

- [ ] Upwork Project Catalog 发布步骤（中文）
  - docs/marketplace/upwork-publish-steps_ZH.md

- [ ] Fiverr 上架流程（中文）
  - docs/marketplace/fiverr-publish-steps_ZH.md

- [ ] 平台限制索引（媒体尺寸/格式/大小/数量）
  - docs/marketplace/assets-index_EN.md

## 4) 最小可交付包（给客户/平台附件用）

- [ ] 一键打包（preflight + build + pack）
  - 说明：docs/marketplace/README.md
  - 命令：scripts/marketplace-build-and-pack.ps1

---

备注：
- 如果平台不允许外链图片，可把图片下载后再上传；raw 直链主要用于“快速预览/复用”。
- 若某个 raw 链接 404，说明该文件未在仓库或路径变更：请先去 docs/assets/README.md 查索引再更新本清单。
