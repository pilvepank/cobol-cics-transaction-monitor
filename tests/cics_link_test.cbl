*>================================================================
*> PROGRAM:  cics_link_test.cbl
*> PURPOSE:  Unit Test Suite for CICS Program Control Stack
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-LINK-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "LINK-STACK.cpy".
 01  WS-ACT                 PIC X(04) VALUE "LINK".
 01  WS-PGM                 PIC X(08) VALUE "PAYROLL1".
 01  WS-LEN                 PIC 9(04) COMP-5 VALUE 128.
 01  WS-STAT                PIC X(02) VALUE '  '.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  CICS EXEC CICS LINK / XCTL STACK TEST SUITE     "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 0 TO LNK-STACK-DEPTH
     MOVE "LINK" TO WS-ACT
     MOVE "PAYROLL1" TO WS-PGM
     MOVE 128 TO WS-LEN
     CALL "CICS-LINK-XCTL" USING LINK-STACK-STATE, WS-ACT, WS-PGM, WS-LEN, WS-STAT
     IF WS-STAT = '00' AND LNK-STACK-DEPTH = 1
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: EXEC CICS LINK Pushes Call Frame [PASS]"
     ELSE
         DISPLAY "TEST 1: EXEC CICS LINK Pushes Call Frame [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "RETN" TO WS-ACT
     CALL "CICS-LINK-XCTL" USING LINK-STACK-STATE, WS-ACT, WS-PGM, WS-LEN, WS-STAT
     IF WS-STAT = '00' AND LNK-STACK-DEPTH = 0
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: EXEC CICS RETURN Pops Call Frame [PASS]"
     ELSE
         DISPLAY "TEST 2: EXEC CICS RETURN Pops Call Frame [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "Link Tests Run:    " WS-TESTS-RUN
     DISPLAY "Link Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL LINK/XCTL TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME LINK/XCTL TESTS FAILED <<"
     END-IF
     STOP RUN.
