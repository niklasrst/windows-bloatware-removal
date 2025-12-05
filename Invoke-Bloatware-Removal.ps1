<#
.SYNOPSIS
   Remove Windows bloatware and default apps from the system.

.DESCRIPTION
    This script removes default Windows apps and bloatware from the system.
    It also creates a registry entry to track the version of the script and to act as a install detection.

.EXAMPLE
   .\invoke-Bloatware-Removal.ps1

.LINK
   https://github.com/niklasrst/windows-bloatware-removal

.AUTHOR
   Niklas Rast
#> 

$ErrorActionPreference = "SilentlyContinue"
$logFile = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\BloatwareRemoval.log"
$companyName = "YourCompanyNameHere"

#Test if registry folder exists
if ($true -ne (test-Path -Path "HKLM:\SOFTWARE\$companyName")) {
    New-Item -Path "HKLM:\SOFTWARE\" -Name "$companyName" -Force
}

Start-Transcript -path $logFile

$bloatwareApps = @(
    "MicrosoftTeams"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    "Microsoft.GamingApp"
    "Microsoft.549981C3F5F10" #Cortana
    "Microsoft.OutlookForWindows"
    "Microsoft.Windows.DevHome"
    "Microsoft.BingSearch"
    "Microsoft.Edge.GameAssist"
    "Microsoft.3DBuilder"
    "Microsoft.Appconnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingTranslator"
    "Microsoft.BingWeather"
    "Microsoft.FreshPaint"
    "Microsoft.GamingServices"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftPowerBIForWindows"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MinecraftUWP"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
    "Microsoft.Windows.Photos"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCalculator"
    "Microsoft.WindowsCamera"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.CommsPhone"
    "Microsoft.ConnectivityStore"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MSPaint"
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.BingTravel"
    "Microsoft.WindowsReadingList"
    "Microsoft.MixedReality.Portal"
    "Microsoft.ScreenSketch"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.YourPhone"
    "Microsoft.Advertising.Xaml"  
)

foreach ($app in $bloatwareApps) {
    Write-Output "Removing $app"
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers
    Get-AppXProvisionedPackage -Online | Where-Object DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online
}

New-Item -Path "HKLM:\SOFTWARE\$companyName\" -Name "BloatwareRemoval"
New-ItemProperty -Path "HKLM:\SOFTWARE\$companyName\BloatwareRemoval" -Name "Version" -PropertyType "String" -Value "1.0.0" -Force

Stop-Transcript
