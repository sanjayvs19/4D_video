Clear-Host
Write-Host "Watching D:\4D\train_n3v_resume.log  (updates every 10s)"
Write-Host "Training keeps running even if you close this window. Ctrl+C stops watching only.`n"
$lastline = ""
while ($true) {
  $c = Get-Content 'D:\4D\train_n3v_resume.log' -Raw -ErrorAction SilentlyContinue
  if ($c) {
    $parts = $c -split 'Training progress:'
    $tail  = ($parts[-1] -replace "`r", "`n")
    $lines = @($tail -split "`n" | Where-Object { $_.Trim() -ne '' })
    if ($lines.Count -gt 0) {
      $line = $lines[-1].Trim()
      if ($line -ne $lastline) {
        $lastline = $line
        $ts = Get-Date -Format 'HH:mm:ss'
        Write-Host ("[$ts] Training progress:" + $line)
      }
    }
    if ($c -match 'TRAIN_N3V_RESUME EXIT') {
      Write-Host "`n=== Training process exited (see log) ===" -ForegroundColor Yellow
      break
    }
  }
  Start-Sleep -Seconds 10
}
