# Variables
$basedir = "$env:userprofile\Documents\NBGI"
$srcdir = "$basedir\Dark Souls Remastered"
$backupdir = "$basedir\Dark Souls Remastered Backup"
$currsave = "$backupdir\current"
$backup1 = "$backupdir\backup1"
$backup2 = "$backupdir\backup2"
$backup3 = "$backupdir\backup3"
$backup4 = "$backupdir\backup4"
$backupcmd = "xcopy /s /c /d /e /i /y"
$totalTime = 600
$remainingTime = 0

# Start the game, if it's not already started.
$process = Get-Process -Name "DarkSoulsRemastered" -ErrorAction SilentlyContinue
if (-not $process) {
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"startgame.bat`""
}

# Backup loop
while ($true) {
    Clear-Host
    Invoke-Expression "$backupcmd `"$backup3`" `"$backup4`""
    Write-Output "Backed up saves to $backup4."
    Write-Output ""
    Invoke-Expression "$backupcmd `"$backup2`" `"$backup3`""
    Write-Output "Backed up saves to $backup3."
    Write-Output ""
    Invoke-Expression "$backupcmd `"$backup1`" `"$backup2`""
    Write-Output "Backed up saves to $backup2."
    Write-Output ""
    Invoke-Expression "$backupcmd `"$currsave`" `"$backup1`""
    Write-Output "Backed up saves to $backup1."
    Write-Output ""
    Invoke-Expression "$backupcmd `"$srcdir`" `"$currsave`""
    Write-Output "Backed up saves to $currsave."
    Write-Output ""
    Write-Output "Backup Complete!"

    for ($remainingTime = $totalTime; $remainingTime -ge 0; $remainingTime--) {
        $percentComplete = (($totalTime - $remainingTime) / $totalTime) * 100
        Write-Progress -Activity "Time to the next backup cycle::" -Status "$remainingTime seconds" -PercentComplete $percentComplete
        Start-Sleep -Seconds 1

        # Check if the game is still running
        $process = Get-Process -Name "DarkSoulsRemastered" -ErrorAction SilentlyContinue
        if (-not $process) {
            break 2  # Exit both loops if the process is not found
        }
    }
}

Write-Output "Exiting..."
