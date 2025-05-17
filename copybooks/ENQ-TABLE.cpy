*>================================================================
*> COPYBOOK: ENQ-TABLE.cpy
*> PURPOSE:  CICS EXEC CICS ENQ / DEQ Named Resource Locks
*> ================================================================
 01  ENQ-DIRECTORY.
     05  ENQ-COUNT               PIC 9(04) COMP-5 VALUE 0.
     05  ENQ-RECORDS OCCURS 16 TIMES INDEXED BY ENQ-IDX.
         10  ENQ-RESOURCE-NAME   PIC X(16) VALUE SPACES.
         10  ENQ-OWNER-TASK      PIC 9(09) COMP-5 VALUE 0.
         10  ENQ-ACTIVE-FLAG     PIC X(01) VALUE 'N'.
