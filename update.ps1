# Check for Windows updates that are not installed and not hidden
$Updates = Get-WindowsUpdate -IsHidden:$false | Where-Object { $_.IsInstalled -eq $false }

# Check if there are updates available
if ($Updates.Count -eq 0) {
    Write-Host "No updates are currently available."
} else {
    # Prompt the user to install updates or delay
    $MaxDelays = 3 # Max nummber of delays
    $DelayInterval = 30 # 30 seconds for testing

    $InstallUpdates = $false  # Initialize flag to indicate whether to install updates

    while ($MaxDelays -gt 0) {
        $Choice = [System.Windows.Forms.MessageBox]::Show(
            "There are new Windows updates available. Please choose one of the following options:`n`nYes) Install updates now and reboot immediately.`nNo) Remind me later.",
            "Windows Updates",
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )

        if ($Choice -eq [System.Windows.Forms.DialogResult]::Yes) {
            $InstallUpdates = $true  # Set flag to install updates
            break
        } elseif ($Choice -eq [System.Windows.Forms.DialogResult]::No) {
            # Delay updates for the specified interval
            Start-Sleep -Seconds $DelayInterval
            $MaxDelays--
        } else {
            break
        }
    }

    if ($InstallUpdates) {
        # Introduce a delay before installing updates and rebooting
        Start-Sleep -Seconds 30  # Introduce a 30-second delay before installation

        # Install updates and reboot
        Install-WindowsUpdate -AcceptAll -AutoReboot
    } else {
        # Warn the user and enforce updates after three delays
        [System.Windows.Forms.MessageBox]::Show(
            "WARNING: You have no other option but to install updates now to keep your system secure. Please save your work. The computer will restart automatically after installation is complete.`n`nThis may take a few minutues.",
            "Windows Updates",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Exclamation
        )
               
                 # Introduce a delay before installing updates and rebooting
        Start-Sleep -Seconds 10  # Introduce a 10-second delay before installation

        # Install updates and reboot
        Install-WindowsUpdate -AcceptAll -AutoReboot
    }
}
