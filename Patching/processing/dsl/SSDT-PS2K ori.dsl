/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200110 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLPnQbyS.aml, Mon Jul 27 02:55:05 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000234 (564)
 *     Revision         0x02
 *     Checksum         0x1F
 *     OEM ID           "hack"
 *     OEM Table ID     "PS2K"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20180427 (538444839)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "PS2K", 0x00000000)
{
    /*
     * iASL Warning: There were 7 external control methods found during
     * disassembly, but only 6 were resolved (1 unresolved). Additional
     * ACPI tables may be required to properly disassemble the code. This
     * resulting disassembler output file may not compile because the
     * disassembler did not know how many arguments to assign to the
     * unresolved methods. Note: SSDTs can be dynamically loaded at
     * runtime and may or may not be available via the host OS.
     *
     * To specify the tables needed to resolve external control method
     * references, the -e option can be used to specify the filenames.
     * Example iASL invocations:
     *     iasl -e ssdt1.aml ssdt2.aml ssdt3.aml -d dsdt.aml
     *     iasl -e dsdt.aml ssdt2.aml -d ssdt1.aml
     *     iasl -e ssdt*.aml -d dsdt.aml
     *
     * In addition, the -fe option can be used to specify a file containing
     * control method external declarations with the associated method
     * argument counts. Each line of the file must be of the form:
     *     External (<method pathname>, MethodObj, <argument count>)
     * Invocation:
     *     iasl -fe refs.txt -d dsdt.aml
     *
     * The following methods were unresolved and many not compile properly
     * because the disassembler had to guess at the number of arguments
     * required for each:
     */
    External (_SB_.ATKD, DeviceObj)
    External (_SB_.ATKD.IANE, MethodObj)    // 1 Arguments
    External (_SB_.ATKD.SKBV.PWKB, BuffObj)
    External (_SB_.KBLV, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.ATKP, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.WRAM, MethodObj)    // 2 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0B, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0E, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0F, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ11, MethodObj)    // 0 Arguments
    External (ATKP, MethodObj)    // Warning: Unknown method, guessing 1 arguments

    Scope (_SB.ATKD)
    {
        Name (KBPW, Buffer (0x11)
        {
            /* 0000 */  0x00, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70,  // .. 0@P`p
            /* 0008 */  0x80, 0x90, 0xA0, 0xB0, 0xC0, 0xD0, 0xE0, 0xF0,  // ........
            /* 0010 */  0xFF                                             // .
        })
        Method (SKBV, 1, NotSerialized)
        {
            KBLV = (Arg0 / 0x10)
            Local0 = DerefOf (PWKB [KBLV])
            ^^PCI0.LPCB.EC0.WRAM (0x04B1, Local0)
            Return (Arg0)
        }
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q0A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x5E)
            }
        }

        Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x7D)
            }

            XQ0B ()
        }

        

        Method (_Q0E, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x20)
            }

            XQ0E ()
        }

        Method (_Q0F, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x10)
            }

            XQ0F ()
        }

        Method (_Q11, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x61)
            }

            XQ11 ()
        }
    }
}

