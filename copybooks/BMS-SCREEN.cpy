*>================================================================*
*> BMS-SCREEN.cpy - IBM 3270 Basic Mapping Support (BMS) Buffer
*>================================================================*
 01  BMS-3270-SCREEN.
     05  SCR-HEADER.
         10  SCR-TITLE           PIC X(36) VALUE "CICS/VS ONLINE BANKING SYSTEM       ".
         10  SCR-DATE            PIC X(10) VALUE "2025-03-28".
         10  SCR-TERMID          PIC X(4)  VALUE "TR01".
         10  SCR-TRANSID         PIC X(4)  VALUE "INQ1".
     05  SCR-LINE-1              PIC X(64) VALUE ALL "-".
     05  SCR-ROW-1               PIC X(64).
     05  SCR-ROW-2               PIC X(64).
     05  SCR-ROW-3               PIC X(64).
     05  SCR-ROW-4               PIC X(64).
     05  SCR-ROW-5               PIC X(64).
     05  SCR-LINE-2              PIC X(64) VALUE ALL "-".
     05  SCR-MESSAGE-LINE        PIC X(64).
     05  SCR-PROMPT-LINE         PIC X(64) VALUE "ENTER=PROCEED | PF3=CANCEL/EXIT".
