Write-Host "Please Be Considerate. This is a software I decided"
Write-Host "to release open source for people who are disk banned."
Write-Host "If you deicde to use, please at least leave credit :("
	Start-Sleep -Milliseconds 5000

function Show-Spinner {
    param (
        [int]$Duration = 8
    )
    $spinnerChars = @('|', '/', '-', '\')
    $endTime = (Get-Date).AddSeconds($Duration)

    while ((Get-Date) -lt $endTime) {
        foreach ($char in $spinnerChars) {
            Write-Host -NoNewline "`r$char"
            Start-Sleep -Milliseconds 150
        }
    }
    Write-Host "`r " -NoNewline  
}

Write-Host "###############################################" -ForegroundColor Green
Write-Host "#      Created by @Purple_Skull_Trooper       #" -ForegroundColor Green
Write-Host "#   https://github.com/purple-skull-trooper   #" -ForegroundColor Green
Write-Host "###############################################" -ForegroundColor Green




$diskDevices = Get-WmiObject Win32_DiskDrive | Select-Object -ExpandProperty PNPDeviceID
foreach ($device in $diskDevices) {
    Write-Host "Spoofing Disk: $device"

    Show-Spinner -Duration 3
    
    $escapedDevice = $device -replace "&", "^&"
    $removeCommand = "pnputil.exe /remove-device $escapedDevice /force"
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c $removeCommand" -NoNewWindow -Wait

    Write-Host "Disks Spoofed: $device"
}
Write-Host "All devices have been processed!"
Start-Process "https://github.com/purple-skull-trooper"