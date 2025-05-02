*>================================================================
*> COPYBOOK: ICP-QUEUE.cpy
*> PURPOSE:  CICS Interval Control Program (ICP) Delayed Start Queue
*> ================================================================
 01  ICP-QUEUE-TABLE.
     05  ICP-TASK-COUNT          PIC 9(04) COMP-5 VALUE 0.
     05  ICP-ENTRIES OCCURS 16 TIMES INDEXED BY ICP-IDX.
         10  ICP-TRANS-ID        PIC X(04) VALUE SPACES.
         10  ICP-DELAY-SECONDS   PIC 9(06) COMP-5 VALUE 0.
         10  ICP-EXPIRY-TIME     PIC 9(18) COMP-5 VALUE 0.
         10  ICP-TASK-DISPATCHED PIC X(01) VALUE 'N'.
