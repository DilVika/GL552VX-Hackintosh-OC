// In config ACPI, _Q80 to XQ80(TP-Fn+F4)
// Find:     5F 51 38 30
// Replace:  58 51 38 30
//
DefinitionBlock("", "SSDT", 2, "OCLT", "FnF4", 0)
{
    External(_SB.PCI9.FNOK, IntObj)
    External(_SB.PCI9.MODE, IntObj)
    External(_SB.LID, DeviceObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.XQ80, MethodObj)

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q80, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (\_SB.PCI9.MODE == 1) //PNP0C0E
                {
                    \_SB.PCI9.FNOK =1
                    \_SB.PCI0.LPCB.EC0.XQ80()
                }
                Else //PNP0C0D
                {
                    If (\_SB.PCI9.FNOK!=1)
                    {
                        \_SB.PCI9.FNOK =1
                    }
                    Else
                    {
                        \_SB.PCI9.FNOK =0
                    }
                    Notify (\_SB.LID, 0x80)
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQ80()
            }
        }
    }
}
//EOF