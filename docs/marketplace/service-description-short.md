# Offline File Organizer — Short Service Description (Upwork / Fiverr)

> Purpose: a shorter, platform-friendly version you can paste into a listing. No pricing, no over-promises.

## 中文（短版）
我可以交付一个**完全离线运行**的文件整理网页工具：
- 批量重命名文件（按模板/序号/日期）
- 导出 CSV 清单（便于对账/交付/归档）
- 可选 ZIP 打包下载；若 ZIP 在你的环境不可用，仍可通过 **Lite 离线兜底**逐个下载

**特点**：零安装（打开 HTML 即用）/ 文件不上传 / 可定制规则 / 可回滚（改动小）

演示：
- 主版本：https://peng1233.github.io/offline-file-organizer/
- Lite：https://peng1233.github.io/offline-file-organizer/lite/

仓库：https://github.com/peng1233/offline-file-organizer

---

## English (short)
I can deliver a **fully offline** browser-based file organizer:
- Batch rename files (template / sequence / date)
- Export a CSV manifest (for tracking, delivery, archiving)
- Optional ZIP download; if ZIP isn’t available, it still works via a **Lite offline fallback** (download one-by-one)

**Highlights**: zero install (open the HTML), no uploads, customizable rules, small & rollback-friendly changes.

Demo:
- Main: https://peng1233.github.io/offline-file-organizer/
- Lite: https://peng1233.github.io/offline-file-organizer/lite/

Repo: https://github.com/peng1233/offline-file-organizer

### Quick FAQ
- **Why “localhost” sometimes?** Some browsers restrict folder access on `file://`. Running a tiny local server enables the File System Access API (optional).
- **Can I use it without ZIP?** Yes — the Lite fallback supports one-by-one downloads (still fully offline).
- **Copy CSV button doesn’t work?** Clipboard permissions vary on `file://`; Lite falls back to a textarea so you can Ctrl+C manually.
