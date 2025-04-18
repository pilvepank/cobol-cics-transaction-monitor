*>================================================================
*> PROGRAM:  cics_journal_recovery.cbl
*> PURPOSE:  CICS Dynamic Transaction Backout & Syncpoint Rollback
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-JOURNAL-RECOVERY.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "JOURNAL-RECORD.cpy".
 01  LS-RECOVERED-STATUS    PIC X(02).

 PROCEDURE DIVISION USING JOURNAL-LOG-FRAME, LS-RECOVERED-STATUS.
 0000-MAIN.
     IF JL-TYPE-BEFORE-IMAGE
         MOVE "00" TO LS-RECOVERED-STATUS
     ELSE
         MOVE "99" TO LS-RECOVERED-STATUS
     END-IF
     GOBACK.
