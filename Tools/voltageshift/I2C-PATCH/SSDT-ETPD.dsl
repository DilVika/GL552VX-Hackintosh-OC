/*
 * Find _CRS:          5F 43 52 53
 * Replace XCRS:       58 43 52 53
 * Target Bridge ETPD: 45545044
 * 
 * Find USTP:          55 53 54 50 08
 * Replace XSTP:       58 53 54 50 08
 */
DefinitionBlock("", "SSDT", 2, "hack", "I2Cpatch", 0)
{
    External(_SB.PCI0.I2C1.ETPD, DeviceObj)
    External(_SB.PCI0.I2C1.ETPD.SBFB, IntObj)
    Name (USTP, One)
    Scope(_SB.PCI0.I2C1.ETPD)
    {
        Name (SBFZ, ResourceTemplate ()
        {
            GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
               "\\ _SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x47
                }
        })
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (ConcatenateResTemplate (SBFB, SBFZ))
            }
    }
}