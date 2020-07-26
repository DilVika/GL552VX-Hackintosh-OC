
DefinitionBlock ("", "SSDT", 2, "hack", "PS2K", 0x00000000)
{

    External (_SB_.ATKD, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0.ALSC, MethodObj)    // 2 Arguments
    External (_SB_.PCI0.LPCB.EC0.RALS, MethodObj)    // 0 Arguments
    External (_SB_.ALS0._ALI,IntObj)
    External (_SB.KBLV, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.WRAM, MethodObj) 
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.ATKP, IntObj)
    External (_SB_.ATKD.IANE, MethodObj)  
    External (_SB_.PCI0.LPCB.EC0_.XQ0B, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0C, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0D, MethodObj)    // 0 Arguments

    External (_SB_.PCI0.LPCB.EC0_.XQ0E, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ0F, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQ11, MethodObj)    // 0 Arguments

    Scope (_SB.ATKD)
    {
        // ALSC and ALSS patchs
           Method (ALSC, 1, NotSerialized)
            {
               // This method does nothing.
            }
            
            Method (ALSS, 0, NotSerialized)
            {

                
                If (CondRefOf(_SB.PCI0.LPCB.EC0.RALS))
                {
                    Return (^^ALS0._ALI)
                }
                Return (0x012C)
               

             }
            
            
            Method (SKBV, 1, NotSerialized)
            {
                 If (_OSI ("Darwin"))
                {
                KBLV = Arg0 / 16
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

