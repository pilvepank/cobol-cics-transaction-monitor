*>================================================================
*> PROGRAM:  cics_interval_control.cbl
*> PURPOSE:  EXEC CICS START DELAY / AFTER Interval Scheduler
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-INTERVAL-CONTROL.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-I                   PIC 9(04) COMP-5.

 LINKAGE SECTION.
 COPY "ICP-QUEUE.cpy".
 01  LS-OP                  PIC X(01). *> 'S' Schedule, 'D' Dispatch check
 01  LS-TRANS-ID            PIC X(04).
 01  LS-DELAY-SEC           PIC 9(06) COMP-5.
 01  LS-CURRENT-TIME        PIC 9(18) COMP-5.
 01  LS-DISPATCH-COUNT      PIC 9(04) COMP-5.

 PROCEDURE DIVISION USING ICP-QUEUE-TABLE, LS-OP, LS-TRANS-ID, LS-DELAY-SEC, LS-CURRENT-TIME, LS-DISPATCH-COUNT.
 0000-MAIN.
     IF LS-OP = 'S'
         IF ICP-TASK-COUNT < 16
             ADD 1 TO ICP-TASK-COUNT
             MOVE LS-TRANS-ID TO ICP-TRANS-ID(ICP-TASK-COUNT)
             MOVE LS-DELAY-SEC TO ICP-DELAY-SECONDS(ICP-TASK-COUNT)
             COMPUTE ICP-EXPIRY-TIME(ICP-TASK-COUNT) = LS-CURRENT-TIME + LS-DELAY-SEC
             MOVE 'N' TO ICP-TASK-DISPATCHED(ICP-TASK-COUNT)
         END-IF
     ELSE
         MOVE 0 TO LS-DISPATCH-COUNT
         PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > ICP-TASK-COUNT
             IF ICP-TASK-DISPATCHED(WS-I) = 'N'
                 IF LS-CURRENT-TIME >= ICP-EXPIRY-TIME(WS-I)
                     MOVE 'Y' TO ICP-TASK-DISPATCHED(WS-I)
                     ADD 1 TO LS-DISPATCH-COUNT
                 END-IF
             END-IF
         END-PERFORM
     END-IF
     GOBACK.
