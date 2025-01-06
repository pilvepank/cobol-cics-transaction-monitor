*>================================================================
*> PROGRAM:  cics_bms_test.cbl
*> PURPOSE:  Test Harness for CICS BMS Compiler
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-BMS-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "BMS-MACRO.cpy".
 01  WS-OFFSET              PIC 9(04) COMP-5 VALUE 0.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  CICS BMS MAPPER TEST SUITE                      "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "ACCTNUM " TO BFD-FIELD-NAME
     MOVE 5 TO BFD-LINE
     MOVE 10 TO BFD-COLUMN
     MOVE 12 TO BFD-LENGTH
     MOVE 'U' TO BFD-ATTR-BYTE
     CALL "CICS-BMS-COMPILER" USING BMS-FIELD-DESCRIPTOR, WS-OFFSET
     *> Offset = ((5 - 1) * 80) + 10 = 320 + 10 = 330
     IF WS-OFFSET = 330
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: BMS Coordinate to Linear Offset [PASS]"
     ELSE
         DISPLAY "TEST 1: BMS Coordinate to Linear Offset [FAIL]"
     END-IF
     
     DISPLAY "--------------------------------------------------"
     DISPLAY "BMS Tests Run:    " WS-TESTS-RUN
     DISPLAY "BMS Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL BMS TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME BMS TESTS FAILED <<"
     END-IF
     STOP RUN.
