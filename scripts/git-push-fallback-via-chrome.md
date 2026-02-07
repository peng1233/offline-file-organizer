# git push 失败时：用 Chrome 网页端兜底提交（OpenClaw）

> 目的：当 `git push` 因 GitHub 443 不稳定（Empty reply / reset / connect timeout）频繁失败时，使用 **已登录的 Google Chrome** 在 GitHub 网页端完成提交，绕开 git 的 HTTPS push 不稳定。
>
> 适用范围：**只处理白名单路径**（避免误改代码）：
> - `docs/`
> - `README.md` / `README_EN.md`
> - `docs/assets/`（截图等）
> - `scripts/`（诊断脚本等）

## 触发条件

- 你已经 `git commit`，但 `scripts/git-push-retry.ps1` 连续失败。

## 一次性准备（只做一次）

1. 用 Chrome 登录 GitHub。
2. 打开仓库页面：
   - https://github.com/peng1233/offline-file-organizer
3. 在该标签页点击 **OpenClaw Browser Relay** 扩展并 Attach。

## 日常使用流程

1. 先正常 push：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\git-push-retry.ps1 -ForceHttp11 -ExponentialBackoff
```

2. 若 push 失败：

- 让 OpenClaw 使用已 attach 的 Chrome 标签页，在 GitHub 网页端对**白名单文件**执行：
  - 文本类：Create new file / Edit file 后提交到 `main`
  - 图片类：Upload files 后提交到 `main`

3. 网页提交成功后：

```powershell
git fetch --prune
# 如果出现分叉（ahead/behind），以远端为准对齐：
# 仅当你确认网页端提交已包含你的改动时再执行
# git reset --hard origin/main
```

## 备注

- 网页自动化可能受 GitHub UI 变动影响；失败时退回到：`git bundle` 保全 + 等网络恢复再 push。
