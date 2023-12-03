*>================================================================*
*> CICS-COMMAREA.cpy - 512-Byte Standard Communication Area Layout
*>================================================================*
 01  DFHCOMMAREA.
     05  CA-HEADER.
         10  CA-TERMID           PIC X(4)    VALUE "TR01".
         10  CA-USERID           PIC X(8)    VALUE "TELLER01".
         10  CA-TRANSID          PIC X(4)    VALUE "INQ1".
         10  CA-NEXT-TRANSID     PIC X(4)    VALUE SPACES.
         10  CA-EIBCALEN         PIC 9(4)    COMP-5 VALUE 512.
         10  CA-EIBRESP          PIC 9(4)    COMP-5 VALUE 0.
             88  RESP-NORMAL     VALUE 0.
             88  RESP-NOTFND     VALUE 13.
             88  RESP-INVREQ     VALUE 16.
             88  RESP-ABEND      VALUE 99.
         10  CA-AID-KEY          PIC X(4)    VALUE "ENTR".
             88  AID-ENTER       VALUE "ENTR".
             88  AID-PF3         VALUE "PF03".
             88  AID-CLEAR       VALUE "CLER".
     05  CA-BODY-RAW             PIC X(488).

     *> Inquiry Transaction Payload
     05  CA-INQ-PAYLOAD REDEFINES CA-BODY-RAW.
         10  INQ-ACCT-NO         PIC X(8).
         10  INQ-ACCT-NAME       PIC X(20).
         10  INQ-BALANCE         PIC S9(9)V99 COMP-3.
         10  INQ-STATUS-MSG      PIC X(40).

     *> Deposit Transaction Payload
     05  CA-DEP-PAYLOAD REDEFINES CA-BODY-RAW.
         10  DEP-ACCT-NO         PIC X(8).
         10  DEP-AMOUNT          PIC 9(7)V99 COMP-3.
         10  DEP-NEW-BALANCE     PIC S9(9)V99 COMP-3.
         10  DEP-STATUS-MSG      PIC X(40).

     *> Multi-Step Transfer Transaction Payload (XFR1 -> XFR2 -> XFR3)
     05  CA-XFR-PAYLOAD REDEFINES CA-BODY-RAW.
         10  XFR-STEP            PIC 9(2)    COMP-5.
         10  XFR-FROM-ACCT       PIC X(8).
         10  XFR-TO-ACCT         PIC X(8).
         10  XFR-AMOUNT          PIC 9(7)V99 COMP-3.
         10  XFR-FEE             PIC 9(3)V99 COMP-3.
         10  XFR-CONFIRMED       PIC X.
             88  XFR-IS-CONFIRMED VALUE "Y".
         10  XFR-STATUS-MSG      PIC X(48).
