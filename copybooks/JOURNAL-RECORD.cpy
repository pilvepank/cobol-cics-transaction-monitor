*>================================================================
*> COPYBOOK: JOURNAL-RECORD.cpy
*> PURPOSE:  CICS System Journal LUW Syncpoint Log Frame Layout
*> ================================================================
 01  JOURNAL-LOG-FRAME.
     05  JL-LSN                  PIC 9(12) COMP-5 VALUE 0.
     05  JL-TASK-NUM             PIC 9(06) COMP-5 VALUE 0.
     05  JL-TRANS-ID             PIC X(04) VALUE "ORDR".
     05  JL-RECORD-TYPE          PIC X(02) VALUE "BI".
         88  JL-TYPE-BEFORE-IMAGE VALUE "BI".
         88  JL-TYPE-AFTER-IMAGE  VALUE "AI".
         88  JL-TYPE-COMMIT       VALUE "CM".
         88  JL-TYPE-ABORT        VALUE "AB".
     05  JL-KEY-ID               PIC X(16) VALUE SPACES.
     05  JL-BEFORE-IMAGE-DATA    PIC X(64) VALUE SPACES.
