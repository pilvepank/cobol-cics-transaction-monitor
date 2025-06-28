*>================================================================
*> COPYBOOK: LINK-STACK.cpy
*> PURPOSE:  CICS EXEC CICS LINK / XCTL Call Stack Frames
*> ================================================================
 01  LINK-STACK-STATE.
     05  LNK-STACK-DEPTH         PIC 9(02) COMP-5 VALUE 0.
     05  LNK-FRAMES OCCURS 8 TIMES INDEXED BY LNK-IDX.
         10  LNK-PROGRAM-NAME    PIC X(08) VALUE SPACES.
         10  LNK-COMMAREA-LEN    PIC 9(04) COMP-5 VALUE 0.
         10  LNK-RETURN-POINT    PIC 9(04) COMP-5 VALUE 0.
