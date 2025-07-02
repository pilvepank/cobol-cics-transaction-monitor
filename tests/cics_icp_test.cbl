*>================================================================
*> PROGRAM:  cics_icp_test.cbl
*> PURPOSE:  Unit Test Suite for CICS Interval Control Engine
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-ICP-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "copybooks/ICP-QUEUE.cpy".
 01  WS-OP                  PIC X(01) VALUE 'S'.
 01  WS-TRN                 PIC X(04) VALUE "PAY1".
 01  WS-DLY                 PIC 9(06) COMP-5 VALUE 60.
 01  WS-NOW                 PIC 9(18) COMP-5 VALUE 1000.
 01  WS-DISP                PIC 9(04) COMP-5 VALUE 0.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  CICS INTERVAL CONTROL PROGRAM (ICP) TEST SUITE  "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 0 TO ICP-TASK-COUNT
     MOVE 'S' TO WS-OP
     MOVE "PAY1" TO WS-TRN
     MOVE 60 TO WS-DLY
     MOVE 1000 TO WS-NOW
     CALL "CICS-INTERVAL-CONTROL" USING ICP-QUEUE-TABLE, WS-OP, WS-TRN, WS-DLY, WS-NOW, WS-DISP
     IF ICP-TASK-COUNT = 1 AND ICP-EXPIRY-TIME(1) = 1060
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Schedule Delayed Task In ICP Queue [PASS]"
     ELSE
         DISPLAY "TEST 1: Schedule Delayed Task In ICP Queue [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 'D' TO WS-OP
     MOVE 1070 TO WS-NOW
     CALL "CICS-INTERVAL-CONTROL" USING ICP-QUEUE-TABLE, WS-OP, WS-TRN, WS-DLY, WS-NOW, WS-DISP
     IF WS-DISP = 1 AND ICP-TASK-DISPATCHED(1) = 'Y'
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Due Task Dispatched Upon Expiry [PASS]"
     ELSE
         DISPLAY "TEST 2: Due Task Dispatched Upon Expiry [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "ICP Tests Run:    " WS-TESTS-RUN
     DISPLAY "ICP Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL ICP TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME ICP TESTS FAILED <<"
     END-IF
     STOP RUN.
