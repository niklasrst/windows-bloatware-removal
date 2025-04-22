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
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    "Microsoft.549981C3F5F10"
    "MicrosoftTeams"
    "Microsoft.DevHome"
    "Microsoft.WindowsFeedbackHub"
    "Clipchamp.Clipchamp"
    "Microsoft.BingNews"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.Xbox.TCUI"          
    "Microsoft.XboxGamingOverlay"        
    "Microsoft.XboxIdentityProvider"        
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.XboxGameCallableUI"
    "MicrosoftCorporationII.QuickAssist"
    "Microsoft.Windows.DevHome"
    "Microsoft.GamingApp"
    "Microsoft.3DBuilder"
    "Microsoft.Appconnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingTranslator"
    "Microsoft.BingWeather"
    "Microsoft.GamingServices"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MinecraftUWP"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.Office.OneNote"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
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
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.BingTravel"
    "Microsoft.WindowsReadingList"
    "Microsoft.MixedReality.Portal"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.YourPhone"
    "Microsoft.Advertising.Xaml"
    "2FE3CB00.PicsArt-PhotoStudio"
    "46928bounde.EclipseManager"
    "4DF9E0F8.Netflix"
    "613EBCEA.PolarrPhotoEditorAcademicEdition"
    "6Wunderkinder.Wunderlist"
    "7EE7776C.LinkedInforWindows"
    "89006A2E.AutodeskSketchBook"
    "9E2F88E3.Twitter"
    "A278AB0D.DisneyMagicKingdoms"
    "A278AB0D.MarchofEmpires"
    "ActiproSoftwareLLC.562882FEEB491"
    "CAF9E577.Plex"  
    "ClearChannelRadioDigital.iHeartRadio"
    "D52A8D61.FarmVille2CountryEscape"
    "D5EA27B7.Duolingo-LearnLanguagesforFree"
    "DB6EA5DB.CyberLinkMediaSuiteEssentials"
    "DolbyLaboratories.DolbyAccess"
    "DolbyLaboratories.DolbyAccess"
    "Drawboard.DrawboardPDF"
    "Facebook.Facebook"
    "Fitbit.FitbitCoach"
    "Flipboard.Flipboard"
    "GAMELOFTSA.Asphalt8Airborne"
    "KeeperSecurityInc.Keeper"
    "Microsoft.BingNews"
    "NORDCURRENT.COOKINGFEVER"
    "PandoraMediaInc.29680B314EFC2"
    "Playtika.CaesarsSlotsFreeCasino"
    "ShazamEntertainmentLtd.Shazam"
    "TheNewYorkTimes.NYTCrossword"
    "ThumbmunkeysLtd.PhototasticCollage"
    "TuneIn.TuneInRadio"
    "WinZipComputing.WinZipUniversal"
    "XINGAG.XING"
    "flaregamesGmbH.RoyalRevolt2"
    "king.com.*"
    "king.com.BubbleWitch3Saga"
    "king.com.CandyCrushSaga"
    "king.com.CandyCrushSodaSaga"
    "Disney.37853FC22B2CE"
    "Clipchamp.Clipchamp"
    "Facebook.InstagramBeta"
    "FACEBOOK.FACEBOOK"
    "BytedancePte.Ltd.TikTok"
    "AmazonVideo.PrimeVideo"   
)

foreach ($app in $bloatwareApps) {
    Write-Output "Removing $app"
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers
    Get-AppXProvisionedPackage -Online | Where-Object DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online
}

New-Item -Path "HKLM:\SOFTWARE\$companyName\" -Name "BloatwareRemoval"
New-ItemProperty -Path "HKLM:\SOFTWARE\$companyName\BloatwareRemoval" -Name "Version" -PropertyType "String" -Value "1.0.0" -Force

Stop-Transcript