$delayCount = 0

# Loop to allow the user to delay reboot twice
while ($delayCount -lt 3) {
    $choice = [System.Windows.Forms.MessageBox]::Show(
        "There are new Windows updates available. Please choose one of the following options:`n`nClick Yes to install updates now and reboot immediately.`nClick No remind me later.",
        "Reboot Required",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Exclamation
    )

    if ($choice -eq [System.Windows.Forms.DialogResult]::Yes) {
        # Reboot the computer
        Restart-Computer -Force
        break
    } else {
        Start-Sleep -Seconds 3  # Delay for 1 minute
        $delayCount++
    }
}

# If user delayed twice or closed the warning box, force reboot
[System.Windows.Forms.MessageBox]::Show(
    "WARNING: You have no other option but to install updates now to keep your system secure. Please save your work.`nThe computer will restart automatically after installation is complete.`n`nThis may take a few minutes.",
    "Reboot Required",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Warning
)
# Reboot the computer
Restart-Computer -Force
