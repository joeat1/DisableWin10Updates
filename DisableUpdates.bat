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

REG add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f
REG add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f
REG add "\HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f
REG add "\HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v "Start" /t REG_DWORD /d "4" /f
REG add "\HKLM\SYSTEM\CurrentControlSet\Services\WpnUserService" /v "Start" /t REG_DWORD /d "4" /f
REG add "\HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d "4" /f

REG add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "FailureActions" /t REG_BINARY /d "80510100000000000000000003000000140000000000000060ea00000000000060ea00000000000000000000" /f
REG add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "FailureActions" /t REG_BINARY /d "840300000000000000000000030000001400000000000000c0d4010000000000e09304000000000000000000" /f
REG add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "FailureActions" /t REG_BINARY /d "805101000000000000000000030000001400000000000000c0d4010000000000e09304000000000000000000" /f


echo  All Done!

pause
