*>================================================================
*> PROGRAM:  cics_enq_deq.cbl
*> PURPOSE:  EXEC CICS ENQ & DEQ Resource Locking Dispatcher
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-ENQ-DEQ.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-I                   PIC 9(04) COMP-5.

 LINKAGE SECTION.
 COPY "ENQ-TABLE.cpy".
 01  LS-OP                  PIC X(01). *> 'E' ENQ, 'D' DEQ
 01  LS-RESOURCE            PIC X(16).
 01  LS-TASK-ID             PIC 9(09) COMP-5.
 01  LS-STATUS              PIC X(02).
     88  ENQ-OK             VALUE '00'.
     88  ENQ-BUSY           VALUE 'BY'.
     88  ENQ-NOT-OWNED      VALUE 'NO'.

 PROCEDURE DIVISION USING ENQ-DIRECTORY, LS-OP, LS-RESOURCE, LS-TASK-ID, LS-STATUS.
 0000-MAIN.
     IF LS-OP = 'E'
         MOVE '00' TO LS-STATUS
         PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > ENQ-COUNT
             IF ENQ-ACTIVE-FLAG(WS-I) = 'Y' AND ENQ-RESOURCE-NAME(WS-I) = LS-RESOURCE
                 IF ENQ-OWNER-TASK(WS-I) NOT = LS-TASK-ID
                     MOVE 'BY' TO LS-STATUS
                 END-IF
             END-IF
         END-PERFORM
         IF LS-STATUS = '00' AND ENQ-COUNT < 16
             ADD 1 TO ENQ-COUNT
             MOVE LS-RESOURCE TO ENQ-RESOURCE-NAME(ENQ-COUNT)
             MOVE LS-TASK-ID TO ENQ-OWNER-TASK(ENQ-COUNT)
             MOVE 'Y' TO ENQ-ACTIVE-FLAG(ENQ-COUNT)
         END-IF
     ELSE
         MOVE 'NO' TO LS-STATUS
         PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > ENQ-COUNT
             IF ENQ-ACTIVE-FLAG(WS-I) = 'Y' AND ENQ-RESOURCE-NAME(WS-I) = LS-RESOURCE
                 IF ENQ-OWNER-TASK(WS-I) = LS-TASK-ID
                     MOVE 'N' TO ENQ-ACTIVE-FLAG(WS-I)
                     MOVE '00' TO LS-STATUS
                 END-IF
             END-IF
         END-PERFORM
     END-IF
     GOBACK.
