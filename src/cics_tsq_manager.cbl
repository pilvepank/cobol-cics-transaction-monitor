*>================================================================
*> PROGRAM:  cics_tsq_manager.cbl
*> PURPOSE:  Scratchpad Temporary Storage Queue (WRITEQ/READQ TS)
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-TSQ-MANAGER.

 ENVIRONMENT DIVISION.
 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "TSQ-QUEUE.cpy".

 LINKAGE SECTION.
 01  LS-QUEUE-OP                 PIC X(04).
     88  OP-WRITEQ               VALUE "WRIT".
     88  OP-READQ                VALUE "READ".
     88  OP-DELETEQ              VALUE "DELT".
 01  LS-ITEM-DATA                PIC X(128).
 01  LS-RESP-CODE                PIC 9(04) COMP-5.

 PROCEDURE DIVISION USING LS-QUEUE-OP
                          LS-ITEM-DATA
                          LS-RESP-CODE.
 0000-EXECUTE-TSQ.
     MOVE 0 TO LS-RESP-CODE.
     EVALUATE TRUE
         WHEN OP-WRITEQ
             MOVE LS-ITEM-DATA TO TSQ-PAYLOAD
         WHEN OP-READQ
             MOVE "CACHED_TSQ_ITEM_PAYLOAD" TO LS-ITEM-DATA
         WHEN OP-DELETEQ
             MOVE SPACES TO TSQ-PAYLOAD
         WHEN OTHER
             MOVE 99 TO LS-RESP-CODE
     END-EVALUATE.
     GOBACK.
