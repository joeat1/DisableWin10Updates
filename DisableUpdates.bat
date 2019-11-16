@echo off
title Disable Windows Update

echo  kill Windows Update services

sc query "wuauserv" | find "RUNNING"
if "%ERRORLEVEL%"=="0" (
sc config "wuauserv" start= disabled
sc stop "wuauserv"
)

sc query "UsoSvc" | find "RUNNING"
if "%ERRORLEVEL%"=="0" (
sc config "UsoSvc" start= disabled
sc stop "UsoSvc"
)
sc query "DoSvc" | find "RUNNING"
if "%ERRORLEVEL%"=="0" (
sc config "DoSvc" start= disabled
sc stop "DoSvc"
)

sc query "BITS" | find "RUNNING"
if "%ERRORLEVEL%"=="0" (
sc config "BITS" start= disabled
sc stop "BITS"
)

echo  Delete scheduled tasks related to Windows Updates

schtasks /delete /tn "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /f 2>nul

schtasks /delete /tn "\Microsoft\Windows\UpdateOrchestrator\Maintenance Install" /f 2>nul
schtasks /delete /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Retry Scan" /f 2>nul
schtasks /delete /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /f 2>nul
schtasks /delete /tn "\Microsoft\Windows\UpdateOrchestrator\USO_Broker_Display" /f 2>nul

schtasks /delete /TN "\Microsoft\Windows\UpdateAssistant\UpdateAssistant" /f 2>nul
schtasks /delete /TN "\Microsoft\Windows\UpdateAssistant\UpdateAssistantAllUsersRun" /f 2>nul
schtasks /delete /TN "\Microsoft\Windows\UpdateAssistant\UpdateAssistantCalendarRun" /f 2>nul
schtasks /delete /TN "\Microsoft\Windows\UpdateAssistant\UpdateAssistantWakeupRun" /f 2>nul

schtasks /delete /tn "\Microsoft\Windows\InstallService\ScanForUpdates" /f 2>nul
schtasks /delete /tn "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /f 2>nul
schtasks /delete /tn "\Microsoft\Windows\InstallService\SmartRetry" /f 2>nul
schtasks /delete /tn "\Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /f 2>nul
schtasks /delete /tn "\Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /f 2>nul

schtasks /delete /tn "\Microsoft\Windows\UNP\RunUpdateNotificationMgr" /f 2>nul


echo Editing Registry



echo  All Done!

pause
