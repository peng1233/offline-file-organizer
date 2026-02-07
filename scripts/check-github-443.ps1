# 4) git ls-remote (HTTPS)
Write-Host "[4/4] Git: git ls-remote (HTTPS)" -ForegroundColor Yellow
try {
  if (Get-Command git -ErrorAction SilentlyContinue) {
    git ls-remote https://github.com/peng1233/offline-file-organizer.git HEAD
    Write-Host "git ls-remote 完成（若上面无报错，说明 HTTPS 基本可用）" -ForegroundColor Green
  } else {
    Write-Host "未找到 git 命令：请先安装 Git for Windows" -ForegroundColor Red
  }
} catch {
  Write-Host "git ls-remote 失败：$($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== 建议 ===" -ForegroundColor Cyan
Write-Host "1) 若 DNS/TCP/HTTPS 都失败：大概率是网络或代理/防火墙问题（先换网络/检查代理）。"
Write-Host "2) 若 HTTPS 可用但 git 偶发失败：可多次重试（仓库内已有 scripts\\git-push-retry.ps1）。"
Write-Host "3) 若长期 443 不稳定：可以考虑切换为 SSH remote（需要配置 SSH key；这会影响你的 Git 设置）。"
