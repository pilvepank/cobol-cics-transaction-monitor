*>================================================================
*> PROGRAM:  cics_recovery_test.cbl
*> PURPOSE:  Test Harness for CICS Syncpoint Journal Rollback
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-RECOVERY-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "copybooks/JOURNAL-RECORD.cpy".
 01  WS-STATUS              PIC X(02) VALUE "  ".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  CICS JOURNAL BACKOUT RECOVERY TEST SUITE        "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 1001 TO JL-LSN
     MOVE 42 TO JL-TASK-NUM
     MOVE "ACCT" TO JL-TRANS-ID
     MOVE "BI" TO JL-RECORD-TYPE
     MOVE "ACCT-00099" TO JL-KEY-ID
     CALL "CICS-JOURNAL-RECOVERY" USING JOURNAL-LOG-FRAME, WS-STATUS
     IF WS-STATUS = "00"
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Before-Image Journal Rollback [PASS]"
     ELSE
         DISPLAY "TEST 1: Before-Image Journal Rollback [FAIL]"
     END-IF
     
     DISPLAY "--------------------------------------------------"
     DISPLAY "Recovery Tests Run:    " WS-TESTS-RUN
     DISPLAY "Recovery Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL RECOVERY TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME RECOVERY TESTS FAILED <<"
     END-IF
     STOP RUN.
