*>================================================================
*> PROGRAM:  cics_enq_test.cbl
*> PURPOSE:  Unit Test Suite for CICS ENQ/DEQ Resource Manager
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-ENQ-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "ENQ-TABLE.cpy".
 01  WS-OP                  PIC X(01) VALUE 'E'.
 01  WS-RES                 PIC X(16) VALUE "ACCOUNT-FILE-CTL".
 01  WS-TASK                PIC 9(09) COMP-5 VALUE 501.
 01  WS-STAT                PIC X(02) VALUE '  '.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  CICS ENQ / DEQ RESOURCE LOCK TEST SUITE         "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 0 TO ENQ-COUNT
     MOVE 'E' TO WS-OP
     MOVE "ACCOUNT-FILE-CTL" TO WS-RES
     MOVE 501 TO WS-TASK
     CALL "CICS-ENQ-DEQ" USING ENQ-DIRECTORY, WS-OP, WS-RES, WS-TASK, WS-STAT
     IF WS-STAT = '00' AND ENQ-COUNT = 1
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Acquire Exclusive ENQ On Resource [PASS]"
     ELSE
         DISPLAY "TEST 1: Acquire Exclusive ENQ On Resource [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 502 TO WS-TASK
     CALL "CICS-ENQ-DEQ" USING ENQ-DIRECTORY, WS-OP, WS-RES, WS-TASK, WS-STAT
     IF WS-STAT = 'BY'
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Conflicting ENQ Contention Rejected [PASS]"
     ELSE
         DISPLAY "TEST 2: Conflicting ENQ Contention Rejected [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "ENQ Tests Run:    " WS-TESTS-RUN
     DISPLAY "ENQ Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL ENQ/DEQ TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME ENQ/DEQ TESTS FAILED <<"
     END-IF
     STOP RUN.
