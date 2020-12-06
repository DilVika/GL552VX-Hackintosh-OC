/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200110 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLPuM6bG.aml, Mon Jul 27 00:16:58 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000076 (118)
 *     Revision         0x02
 *     Checksum         0xE0
 *     OEM ID           "OCLT"
 *     OEM Table ID     "EXT1"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200110 (538968336)
 */
DefinitionBlock ("", "SSDT", 2, "OCLT", "EXT1", 0x00000000)
{
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)

    Method (EXT1, 1, NotSerialized)
    {
        If (((0x05 == Arg0) && CondRefOf (\_SB.PCI0.XHC.PMEE)))
        {
            \_SB.PCI0.XHC.PMEE = Zero
        }
    }
}

