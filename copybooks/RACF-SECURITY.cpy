*>================================================================
*> COPYBOOK: RACF-SECURITY.cpy
*> PURPOSE:  Mainframe RACF User Security & Transaction ACLs
*> ================================================================
 01  RACF-USER-PROFILE.
     05  RACF-USER-ID            PIC X(08).
     05  RACF-SECURITY-GROUP     PIC X(08).
     05  RACF-CLEARANCE-LEVEL    PIC 9(02) COMP-5.
     05  RACF-AUTH-TRANSACTIONS  PIC X(32).
     05  RACF-LOGON-STATUS       PIC X(01).
         88  RACF-AUTHORIZED     VALUE 'Y'.
         88  RACF-DENIED         VALUE 'N'.
