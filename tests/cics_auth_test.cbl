*>================================================================
*> PROGRAM:  cics_auth_test.cbl
*> PURPOSE:  Security ACL & RACF Authorization Unit Test Suite
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-AUTH-TEST.

 ENVIRONMENT DIVISION.
 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-USER                     PIC X(08) VALUE "TELLER01".
 01  WS-TRAN                     PIC X(04) VALUE "DEP1".
 01  WS-STATUS                   PIC 9(02) COMP-5 VALUE 0.
 01  WS-TESTS-RUN                PIC 9(04) COMP-5 VALUE 0.
 01  WS-TESTS-PASSED             PIC 9(04) COMP-5 VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "==================================================".
     DISPLAY "  CICS RACF SECURITY & ACL VERIFICATION SUITE     ".
     DISPLAY "==================================================".

     ADD 1 TO WS-TESTS-RUN.
     MOVE "TELLER01" TO WS-USER.
     MOVE "DEP1" TO WS-TRAN.
     CALL "CICS-RACF-AUTH" USING WS-USER WS-TRAN WS-STATUS.
     IF WS-STATUS = 0
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Authorized Teller Transaction Check [PASS]"
     END-IF.

     ADD 1 TO WS-TESTS-RUN.
     MOVE "TELLER01" TO WS-USER.
     MOVE "REST" TO WS-TRAN.
     CALL "CICS-RACF-AUTH" USING WS-USER WS-TRAN WS-STATUS.
     IF WS-STATUS = 1
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Unauthorized Admin Transaction Rejection [PASS]"
     END-IF.

     DISPLAY "--------------------------------------------------".
     DISPLAY "TEST SUMMARY: " WS-TESTS-PASSED " / " WS-TESTS-RUN " PASSED.".
     DISPLAY "==================================================".
     IF WS-TESTS-PASSED = WS-TESTS-RUN
         DISPLAY ">> ALL CICS SECURITY INVARIANTS VERIFIED [100% OK] <<"
     END-IF.
     STOP RUN.
