*>================================================================
*> PROGRAM:  cics_bms_compiler.cbl
*> PURPOSE:  CICS Basic Mapping Support (BMS) Macro Processor
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CICS-BMS-COMPILER.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "BMS-MACRO.cpy".
 01  LS-SCREEN-OFFSET       PIC 9(04) COMP-5.

 PROCEDURE DIVISION USING BMS-FIELD-DESCRIPTOR, LS-SCREEN-OFFSET.
 0000-MAIN.
     *> Convert 2D 24x80 coordinates into linear 1920-byte terminal offset
     COMPUTE LS-SCREEN-OFFSET = ((BFD-LINE - 1) * 80) + BFD-COLUMN
     GOBACK.
