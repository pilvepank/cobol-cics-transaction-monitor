*>================================================================
*> COPYBOOK: TSQ-QUEUE.cpy
*> PURPOSE:  CICS Temporary Storage Queue (TSQ) Control Layout
*> ================================================================
 01  TSQ-CONTROL-BLOCK.
     05  TSQ-NAME                PIC X(08).
     05  TSQ-ITEM-NUM            PIC 9(04) COMP-5.
     05  TSQ-NUM-ITEMS           PIC 9(04) COMP-5.
     05  TSQ-ITEM-LENGTH         PIC 9(04) COMP-5.
     05  TSQ-PAYLOAD             PIC X(128).
