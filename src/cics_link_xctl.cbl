*>================================================================
*> PROGRAM:  cics_link_xctl.cbl
*> PURPOSE:  EXEC CICS LINK & XCTL Inter-Program Call Frame Manager
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-LINK-XCTL.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "LINK-STACK.cpy".
 01  LS-ACTION              PIC X(04). *> "LINK", "XCTL", "RETN"
 01  LS-PROG-NAME           PIC X(08).
 01  LS-COMMAREA-LEN        PIC 9(04) COMP-5.
 01  LS-STATUS              PIC X(02).
     88  LNK-OK             VALUE '00'.
     88  LNK-STACK-OVERFLOW VALUE 'SO'.
     88  LNK-STACK-UNDERFLOW VALUE 'SU'.

 PROCEDURE DIVISION USING LINK-STACK-STATE, LS-ACTION, LS-PROG-NAME, LS-COMMAREA-LEN, LS-STATUS.
 0000-MAIN.
     EVALUATE LS-ACTION
         WHEN "LINK"
             IF LNK-STACK-DEPTH < 8
                 ADD 1 TO LNK-STACK-DEPTH
                 MOVE LS-PROG-NAME TO LNK-PROGRAM-NAME(LNK-STACK-DEPTH)
                 MOVE LS-COMMAREA-LEN TO LNK-COMMAREA-LEN(LNK-STACK-DEPTH)
                 MOVE '00' TO LS-STATUS
             ELSE
                 MOVE 'SO' TO LS-STATUS
             END-IF
         WHEN "XCTL"
             IF LNK-STACK-DEPTH > 0
                 MOVE LS-PROG-NAME TO LNK-PROGRAM-NAME(LNK-STACK-DEPTH)
                 MOVE LS-COMMAREA-LEN TO LNK-COMMAREA-LEN(LNK-STACK-DEPTH)
                 MOVE '00' TO LS-STATUS
             ELSE
                 MOVE 'SU' TO LS-STATUS
             END-IF
         WHEN "RETN"
             IF LNK-STACK-DEPTH > 0
                 SUBTRACT 1 FROM LNK-STACK-DEPTH
                 MOVE '00' TO LS-STATUS
             ELSE
                 MOVE 'SU' TO LS-STATUS
             END-IF
     END-EVALUATE
     GOBACK.
