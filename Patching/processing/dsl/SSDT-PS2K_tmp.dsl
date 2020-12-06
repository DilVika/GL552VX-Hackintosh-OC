/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200110 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASL1CYEzl.aml, Mon Jul 27 04:08:04 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000002FE (766)
 *     Revision         0x02
 *     Checksum         0xD1
 *     OEM ID           "hack"
 *     OEM Table ID     "PS2K"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200110 (538968336)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "PS2K", 0x00000000)
{
    /*
     * iASL Warning: There were 9 external control methods found during
     * disassembly, but only 8 were resolved (1 unresolved). Additional
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
    External (_SB_.ALS0._ALI, IntObj)
    External (_SB_.ATKD, DeviceObj)
    External (_SB_.ATKD.IANE, MethodObj)    // 1 Arguments
    External (_SB_.KBLV, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.ATKP, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.WRAM, MethodObj)    // 2 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0B, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0C, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0D, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0E, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0F, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ11, MethodObj)    // 0 Arguments
    External (ATKP, MethodObj)    // Warning: Unknown method, guessing 1 arguments

    Scope (_SB.ATKD)
    {
        Method (ALSC, 1, NotSerialized)
        {
        }

        Method (ALSS, 0, NotSerialized)
        {
            If (CondRefOf (_SB.PCI0.LPCB.EC0.RALS))
            {
                Return (^^ALS0._ALI) /* External reference */
            }

            Return (0x012C)
        }

        Method (SKBV, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                KBLV = (Arg0 / 0x10)
                ^^PCI0.LPCB.EC0.WRAM (0x04B1, Arg0)
                Return (Arg0)
            }
        }
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                If (ATKP)
                {
                    \_SB.ATKD.IANE (0x7D)
                }
            }

            XQ0B ()
        }

        Method (_Q0C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                If (ATKP)
                {
                    \_SB.ATKD.IANE (0xC5)
                }
            }

            XQ0C ()
        }

        Method (_Q0D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                If (ATKP)
                {
                    \_SB.ATKD.IANE (0xC4)
                }
            }

            XQ0D ()
        }

        Method (_Q0E, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                If (ATKP)
                {
                    \_SB.ATKD.IANE (0x20)
                }
            }

            XQ0E ()
        }

        Method (_Q0F, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                If (ATKP)
                {
                    \_SB.ATKD.IANE (0x10)
                }
            }

            XQ0F ()
        }

        Method (_Q11, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                If (ATKP)
                {
                    \_SB.ATKD.IANE (0x61)
                }
            }

            XQ11 ()
        }
    }
}

