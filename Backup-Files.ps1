Write-Host "Saving the following files" `
    "to the ""Backup"" directory:"
$BUCount = 0
$BUSize = 0

Get-ChildItem -File | where {
    $_.LastWriteTime -ge "2011-01-01" } |
ForEach-Object {
    Write-Host "Backup\$($_.Name)"
    $BUSize += $_.Length
    $BUCount ++
    $FileName = [io.path]::GetFileNameWithoutExtension($_.name)
    $FileType = [io.path]::GetExtension($_.Name)
    $NewFileName = "Backup\$FileName" + "_" + $_.LastWriteTime.ToString("yyyy-MM-dd") + $FileType
    #$NewFileName = "Backup\" + $_.Name + "_" + $_.LastWriteTime.ToString("yyyy-MM-dd")
    Copy-Item $_ $NewFileName }
Write-Host "Saved:" $BUCount "files," `
    $BUSize.ToString("n0") "bytes"