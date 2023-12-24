*>================================================================*
*> CICS-TABLES.cpy - PCT, PPT, TCT and Journal Data Structures
*>================================================================*
 78  MAX-PCT-ENTRIES             VALUE 8.
 78  MAX-TCT-TERMS               VALUE 4.
 78  MAX-JOURNAL-ENTRIES         VALUE 16.
 78  MAX-ACCOUNTS                VALUE 8.

*> Program Control Table (PCT): Maps 4-character Trans-ID to Program Name
 01  PCT-TABLE.
     05  PCT-COUNT               PIC 9(2) COMP-5 VALUE 5.
     05  PCT-ENTRY OCCURS 8 TIMES.
         10  PCT-TRANS-ID        PIC X(4).
         10  PCT-PROGRAM-NAME    PIC X(8).
         10  PCT-DESCRIPTION     PIC X(24).

*> Terminal Control Table (TCT): In-Memory Pseudo-Conversational Sessions
 01  TCT-TABLE.
     05  TCT-COUNT               PIC 9(2) COMP-5 VALUE 2.
     05  TCT-ENTRY OCCURS 4 TIMES.
         10  TCT-TERM-ID         PIC X(4).
         10  TCT-USER-ID         PIC X(8).
         10  TCT-ACTIVE-TRANS    PIC X(4).
         10  TCT-NEXT-TRANS      PIC X(4).
         10  TCT-SAVED-COMMAREA  PIC X(512).

*> Logical Unit of Work (LUW) Journal for Two-Phase Rollback
 01  JOURNAL-TABLE.
     05  JRN-COUNT               PIC 9(4) COMP-5 VALUE 0.
     05  JRN-ENTRY OCCURS 16 TIMES.
         10  JRN-LUW-ID          PIC 9(6) COMP-5.
         10  JRN-TRANS-ID        PIC X(4).
         10  JRN-ACCT-ID         PIC X(8).
         10  JRN-OLD-BAL         PIC S9(9)V99 COMP-3.
         10  JRN-NEW-BAL         PIC S9(9)V99 COMP-3.
         10  JRN-STATUS          PIC X.
             88  JRN-PENDING     VALUE "P".
             88  JRN-COMMITTED   VALUE "C".
             88  JRN-ROLLED-BACK VALUE "R".

*> Account Master File (In-Memory Database)
 01  ACCOUNT-DATABASE.
     05  ACCT-COUNT              PIC 9(2) COMP-5 VALUE 4.
     05  ACCT-ENTRY OCCURS 8 TIMES.
         10  ACC-ID              PIC X(8).
         10  ACC-NAME            PIC X(20).
         10  ACC-BALANCE         PIC S9(9)V99 COMP-3.
         10  ACC-STATUS          PIC X.
             88  ACC-ACTIVE      VALUE "A".
             88  ACC-FROZEN      VALUE "F".
