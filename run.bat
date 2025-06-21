@echo off
call build.bat
cics_dispatcher.exe
cics_test.exe
cics_auth_test.exe
cics_bms_test.exe
cics_recovery_test.exe
cics_icp_test.exe
cics_enq_test.exe
cics_link_test.exe
