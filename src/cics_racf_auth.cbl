*>================================================================
*> PROGRAM:  cics_racf_auth.cbl
*> PURPOSE:  Mainframe Operator Authentication & ACL Enforcement
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-RACF-AUTH.

 ENVIRONMENT DIVISION.
 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "RACF-SECURITY.cpy".

 LINKAGE SECTION.
 01  LS-USER-ID                  PIC X(08).
 01  LS-TRAN-ID                  PIC X(04).
 01  LS-AUTH-STATUS              PIC 9(02) COMP-5.
     88  AUTH-ALLOWED            VALUE 0.
     88  AUTH-UNAUTHORIZED       VALUE 1.
     88  AUTH-USER-LOCKED        VALUE 2.

 PROCEDURE DIVISION USING LS-USER-ID
                          LS-TRAN-ID
                          LS-AUTH-STATUS.
 0000-CHECK-AUTH.
     MOVE 0 TO LS-AUTH-STATUS.
     IF LS-USER-ID = "SEC_LOCK"
         SET AUTH-USER-LOCKED TO TRUE
     ELSE
         IF LS-TRAN-ID = "REST" AND LS-USER-ID NOT = "SYSADMIN"
             SET AUTH-UNAUTHORIZED TO TRUE
         ELSE
             SET AUTH-ALLOWED TO TRUE
         END-IF
     END-IF.
     GOBACK.
