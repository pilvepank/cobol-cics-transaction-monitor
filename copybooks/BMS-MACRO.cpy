*>================================================================
*> COPYBOOK: BMS-MACRO.cpy
*> PURPOSE:  Basic Mapping Support Screen Descriptor Macro Layout
*> ================================================================
 01  BMS-FIELD-DESCRIPTOR.
     05  BFD-FIELD-NAME          PIC X(08).
     05  BFD-LINE                PIC 9(02) COMP-5.
     05  BFD-COLUMN              PIC 9(02) COMP-5.
     05  BFD-LENGTH              PIC 9(02) COMP-5.
     05  BFD-ATTR-BYTE           PIC X(01).
         88  BFD-ATTR-UNPROT     VALUE 'U'.
         88  BFD-ATTR-PROT       VALUE 'P'.
         88  BFD-ATTR-NUMERIC    VALUE 'N'.
