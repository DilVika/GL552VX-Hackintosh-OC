/*

 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "BATT", 0x00000000)
{
    External (_SB_.PCI0.LPCB.EC0, DeviceObj)
    External (_SB.PCI0.BAT0,DeviceObj)
    External (_SB_.PCI0.LPCB.EC0.ECAV, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.XIFA, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.SWTC, MethodObj) 
    External (_SB_.PCI0.LPCB.EC0.XMBW, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.ECSX, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.BATP, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.GBTT, MethodObj)
    External (_SB_.PCI0.BAT0._BIF, MethodObj)
    External (_SB_.PCI0.BAT0.XBIX, MethodObj)

    External (_SB_.PCI0.LPCB.EC0.XMBR, MethodObj)
    
    External (BSLF, IntObj)
    External (_SB_.PCI0.LPCB.EC0.WRBT, IntObj) 
    External (_SB_.PCI0.LPCB.EC0.WRQK, IntObj)
    External (_SB_.PCI0.LPCB.EC0.SDBT, IntObj) 
    External (_SB_.PCI0.LPCB.EC0.RDBL, IntObj)
    External (_SB_.PCI0.LPCB.EC0.RDWD, IntObj)
    External (_SB_.PCI0.LPCB.EC0.RDBT, IntObj)
    External (_SB_.PCI0.LPCB.EC0.RCBT, IntObj)
    External (_SB_.PCI0.LPCB.EC0.RDQK, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.SBBY, IntObj) 
    External (_SB_.PCI0.LPCB.EC0_.WRBL, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.WRWD, IntObj)
    
    External (_SB_.PCI0.LPCB.EC0.MUEC, MutexObj)
    
    External (_SB_.PCI0.LPCB.EC0.SST2, FieldUnitObj) 
    External (_SB_.PCI0.LPCB.EC0.SSTS, FieldUnitObj)    
    External (_SB_.PCI0.LPCB.EC0.DA21, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.DA20, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.BCN2, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.CMD2, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.PRT2, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.PRTC, FieldUnitObj) 
    External (_SB_.PCI0.LPCB.EC0.ADDR, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.CMDB, FieldUnitObj) 
    External (_SB_.PCI0.LPCB.EC0.BCNT, FieldUnitObj) 
    External (_SB_.PCI0.LPCB.EC0_.DAT0, FieldUnitObj) 
    External (_SB_.PCI0.LPCB.EC0.DAT1, FieldUnitObj) 
    External (_SB_.PCI0.LPCB.EC0.ADD2, FieldUnitObj)
    
    External (_SB_.PCI0.BAT0.BIXT, PkgObj) 
    External (_SB_.PCI0.BAT0.NBIX, PkgObj)
    External (_SB_.PCI0.BAT0.PBIF, PkgObj) 

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }

    Method (B1B4, 4, NotSerialized)
    {
        Local0 = (Arg2 | (Arg3 << 0x08))
        Local0 = (Arg1 | (Local0 << 0x08))
        Local0 = (Arg0 | (Local0 << 0x08))
        Return (Local0)
    }

    Method (W16B, 3, NotSerialized)
    {
        Arg0 = Arg2
        Arg1 = (Arg2 >> 0x08)
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (RE1B, 1, NotSerialized)
        {
            OperationRegion (ERM2, EmbeddedControl, Arg0, One)
            Field (ERM2, ByteAcc, NoLock, Preserve)
            {
                BYTE,   8
            }

            Return (BYTE) 
        }

        Method (RECB, 2, Serialized)
        {
            Arg1 = ((Arg1 + 0x07) >> 0x03)
            Name (TEMP, Buffer (Arg1){})
            Arg1 += Arg0
            Local0 = Zero
            While ((Arg0 < Arg1))
            {
                TEMP [Local0] = RE1B (Arg0)
                Arg0++
                Local0++
            }

            Return (TEMP)
        }

        Method (WE1B, 2, NotSerialized)
        {
            OperationRegion (ERM2, EmbeddedControl, Arg0, One)
            Field (ERM2, ByteAcc, NoLock, Preserve)
            {
                BYTE,   8
            }

            BYTE = Arg1
        }

        Method (WECB, 3, Serialized)
        {
            Arg1 = ((Arg1 + 0x07) >> 0x03)
            Name (TEMP, Buffer (Arg1){})
            TEMP = Arg2
            Arg1 += Arg0
            Local0 = Zero
            While ((Arg0 < Arg1))
            {
                WE1B (Arg0, DerefOf (TEMP [Local0]))
                Arg0++
                Local0++
            }
        }

        OperationRegion (ECOX, EmbeddedControl, Zero, 0xFF)
        Field (ECOX, ByteAcc, Lock, Preserve)
            {
                Offset(0xC4),
                B0CL,8, B0CH,8, //B0C3
                Offset (0xF4), 
                B0SL, 8, B0SH, 8, //B0SN 
                Offset (0xFC), 
                B1SL, 8, B1SH, 8, //B1SN
            }
        OperationRegion (SMBY, EmbeddedControl, 0x18, 0x28)
        Field (SMBY, ByteAcc, NoLock, Preserve)
            {
                Offset (0x04), 
                DT2L,8, DT2H, 8, //DT2B 
            }

        Method (BIFA, 0, NotSerialized)
        {
          If (_OSI ("Darwin"))
           {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1B2(B1SL, B1SH) /* \_SB_.PCI0.LPCB.EC0_.B1SN */
                }
                Else
                {
                    Local0 = B1B2(B0SL, B0SH) /* \_SB_.PCI0.LPCB.EC0_.B0SN */
                }
            }
            
            Else
            {
                Local0 = Ones
            }

            Return (Local0) 
            }
          Else
                {
                    Return (XIFA ())
                } 
        }

        Method (SMBR, 3, Serialized)
        {
         If (_OSI ("Darwin"))
          {
            Local0 = Package (0x03)
                {
                    0x07, 
                    Zero, 
                    Zero
                }
            If (!ECAV ())
            {
                Return (Local0)
            }

            If ((Arg0 != RDBL))
            {
                If ((Arg0 != RDWD))
                {
                    If ((Arg0 != RDBT))
                    {
                        If ((Arg0 != RCBT))
                        {
                            If ((Arg0 != RDQK))
                            {
                                Return (Local0)
                            }
                        }
                    }
                }
            }

            Acquire (MUEC, 0xFFFF)
            Local1 = PRTC /* \_SB_.PCI0.LPCB.EC0_.PRTC */
            Local2 = Zero
            While ((Local1 != Zero))
            {
                Stall (0x0A)
                Local2++
                If ((Local2 > 0x03E8))
                {
                    Local0 [Zero] = SBBY /* \_SB_.PCI0.LPCB.EC0_.SBBY */
                    Local1 = Zero
                }
                Else
                {
                    Local1 = PRTC /* \_SB_.PCI0.LPCB.EC0_.PRTC */
                }
            }

            If ((Local2 <= 0x03E8))
            {
                Local3 = (Arg1 << One)
                Local3 |= One
                ADDR = Local3
                If ((Arg0 != RDQK))
                {
                    If ((Arg0 != RCBT))
                    {
                        CMDB = Arg2
                    }
                }

                WECB (0x1C, 0x0100, Zero) //BDAT
                PRTC = Arg0
                Local0 [Zero] = SWTC (Arg0)
                If ((DerefOf (Local0 [Zero]) == Zero))
                {
                    If ((Arg0 == RDBL))
                    {
                        Local0 [One] = BCNT /* \_SB_.PCI0.LPCB.EC0_.BCNT */
                        Local0 [0x02] = RECB (0x1C, 0x0100) /* \_SB_.PCI0.LPCB.EC0_.BDAT */
                    }

                    If ((Arg0 == RDWD))
                    {
                        Local0 [One] = 0x02
                        Local0 [0x02] = B1B2(DT2L, DT2H) /* \_SB_.PCI0.LPCB.EC0_.DT2B */
                    }

                    If ((Arg0 == RDBT))
                    {
                        Local0 [One] = One
                        Local0 [0x02] = DAT0 /* \_SB_.PCI0.LPCB.EC0_.DAT0 */
                    }

                    If ((Arg0 == RCBT))
                    {
                        Local0 [One] = One
                        Local0 [0x02] = DAT0 /* \_SB_.PCI0.LPCB.EC0_.DAT0 */
                    }
                }
            }

            Release (MUEC)
            Return (Local0)
         }
            Else
            {
            Return (XMBR(Arg0, Arg1, Arg2))
            }
        }

        Method (SMBW, 5, Serialized)
        {
          If (_OSI ("Darwin"))
          {
            Local0 = Package (0x01)
                {
                    0x07
                }
            If (!ECAV ())
            {
                Return (Local0)
            }

            If ((Arg0 != WRBL))
            {
                If ((Arg0 != WRWD))
                {
                    If ((Arg0 != WRBT))
                    {
                        If ((Arg0 != SDBT))
                        {
                            If ((Arg0 != WRQK))
                            {
                                Return (Local0)
                            }
                        }
                    }
                }
            }

            Acquire (MUEC, 0xFFFF)
            Local1 = PRTC /* \_SB_.PCI0.LPCB.EC0_.PRTC */
            Local2 = Zero
            While ((Local1 != Zero))
            {
                Stall (0x0A)
                Local2++
                If ((Local2 > 0x03E8))
                {
                    Local0 [Zero] = SBBY /* \_SB_.PCI0.LPCB.EC0_.SBBY */
                    Local1 = Zero
                }
                Else
                {
                    Local1 = PRTC /* \_SB_.PCI0.LPCB.EC0_.PRTC */
                }
            }

            If ((Local2 <= 0x03E8))
            {
                WECB (0x1C, 0x0100, Zero)  // BDAT
                Local3 = (Arg1 << One)
                ADDR = Local3
                If ((Arg0 != WRQK))
                {
                    If ((Arg0 != SDBT))
                    {
                        CMDB = Arg2
                    }
                }

                If ((Arg0 == WRBL))
                {
                    BCNT = Arg3
                    WECB (0x1C, 0x0100, Arg4) //BDAT
                }

                If ((Arg0 == WRWD))
                {
                    W16B(DT2L, DT2H, Arg4)
                }

                If ((Arg0 == WRBT))
                {
                    DAT0 = Arg4
                }

                If ((Arg0 == SDBT))
                {
                    DAT0 = Arg4
                }

                PRTC = Arg0
                Local0 [Zero] = SWTC (Arg0)
            }

            Release (MUEC)
            Return (Local0) }
          Else 
          {
              Return (XMBW(Arg0, Arg1, Arg2, Arg3, Arg4))
          }
        }

        Method (ECSB, 7, NotSerialized)
        {
         If (_OSI ("Darwin"))
           {
            Local1 = Package (0x05)
                {
                    0x11, 
                    Zero, 
                    Zero, 
                    Zero, 
                    Buffer (0x20){}
                }
            If ((Arg0 > One))
            {
                Return (Local1)
            }

            If (ECAV ())
            {
                Acquire (MUEC, 0xFFFF)
                If ((Arg0 == Zero))
                {
                    Local0 = PRTC /* \_SB_.PCI0.LPCB.EC0_.PRTC */
                }
                Else
                {
                    Local0 = PRT2 /* \_SB_.PCI0.LPCB.EC0_.PRT2 */
                }

                Local2 = Zero
                While ((Local0 != Zero))
                {
                    Stall (0x0A)
                    Local2++
                    If ((Local2 > 0x03E8))
                    {
                        Local1 [Zero] = SBBY /* \_SB_.PCI0.LPCB.EC0_.SBBY */
                        Local0 = Zero
                    }
                    ElseIf ((Arg0 == Zero))
                    {
                        Local0 = PRTC /* \_SB_.PCI0.LPCB.EC0_.PRTC */
                    }
                    Else
                    {
                        Local0 = PRT2 /* \_SB_.PCI0.LPCB.EC0_.PRT2 */
                    }
                }

                If ((Local2 <= 0x03E8))
                {
                    If ((Arg0 == Zero))
                    {
                        ADDR = Arg2
                        CMDB = Arg3
                        If (((Arg1 == 0x0A) || (Arg1 == 0x0B)))
                        {
                            BCNT = DerefOf (Arg6 [Zero])
                            WECB (0x1C, 0x0100, DerefOf (Arg6 [One])) //BDAT = DerefOf (Arg6 [One])
                        }
                        Else
                        {
                            DAT0 = Arg4
                            DAT1 = Arg5
                        }

                        PRTC = Arg1
                    }
                    Else
                    {
                        ADD2 = Arg2
                        CMD2 = Arg3
                        If (((Arg1 == 0x0A) || (Arg1 == 0x0B)))
                        {
                            BCN2 = DerefOf (Arg6 [Zero])
                            WECB (0x44, 0x0100, DerefOf (Arg6 [One]))    // BDA2 = DerefOf (Arg6 [One])
                        }
                        Else
                        {
                            DA20 = Arg4
                            DA21 = Arg5
                        }

                        PRT2 = Arg1
                    }

                    Local0 = 0x7F
                    If ((Arg0 == Zero))
                    {
                        While (PRTC)
                        {
                            Sleep (One)
                            Local0--
                        }
                    }
                    Else
                    {
                        While (PRT2)
                        {
                            Sleep (One)
                            Local0--
                        }
                    }

                    If (Local0)
                    {
                        If ((Arg0 == Zero))
                        {
                            Local0 = SSTS /* \_SB_.PCI0.LPCB.EC0_.SSTS */
                            Local1 [One] = DAT0 /* \_SB_.PCI0.LPCB.EC0_.DAT0 */
                            Local1 [0x02] = DAT1 /* \_SB_.PCI0.LPCB.EC0_.DAT1 */
                            Local1 [0x03] = BCNT /* \_SB_.PCI0.LPCB.EC0_.BCNT */
                            Local1 [0x04] = RECB (0x1C, 0x0100)  //BDAT /* \_SB_.PCI0.LPCB.EC0_.BDAT */
                        }
                        Else
                        {
                            Local0 = SST2 /* \_SB_.PCI0.LPCB.EC0_.SST2 */
                            Local1 [One] = DA20 /* \_SB_.PCI0.LPCB.EC0_.DA20 */
                            Local1 [0x02] = DA21 /* \_SB_.PCI0.LPCB.EC0_.DA21 */
                            Local1 [0x03] = BCN2 /* \_SB_.PCI0.LPCB.EC0_.BCN2 */
                            Local1 [0x04] = RECB (0x1C, 0x0100) //BDA2 /* \_SB_.PCI0.LPCB.EC0_.BDA2 */
                        }

                        Local0 &= 0x1F
                        If (Local0)
                        {
                            Local0 += 0x10
                        }

                        Local1 [Zero] = Local0
                    }
                    Else
                    {
                        Local1 [Zero] = 0x10
                    }
                }

                Release (MUEC)
            }

            Return (Local1) }
         Else 
         {
             Return (ECSX(Arg0, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6))
         }
        }


    }

    Scope (_SB.PCI0.BAT0)
    {
          Method (_BIX, 0, NotSerialized)  // _BIX: Battery Information Extended
            {
              If (_OSI ("Darwin"))
               {
                If (!^^LPCB.EC0.BATP (Zero))
                {
                    Return (NBIX) /* \_SB_.PCI0.BAT0.NBIX */
                }

                If ((^^LPCB.EC0.GBTT (Zero) == 0xFF))
                {
                    Return (NBIX) /* \_SB_.PCI0.BAT0.NBIX */
                }

                _BIF ()
                BIXT [One] = DerefOf (PBIF [Zero])
                BIXT [0x02] = DerefOf (PBIF [One])
                BIXT [0x03] = DerefOf (PBIF [0x02])
                BIXT [0x04] = DerefOf (PBIF [0x03])
                BIXT [0x05] = DerefOf (PBIF [0x04])
                BIXT [0x06] = DerefOf (PBIF [0x05])
                BIXT [0x07] = DerefOf (PBIF [0x06])
                BIXT [0x0E] = DerefOf (PBIF [0x07])
                BIXT [0x0F] = DerefOf (PBIF [0x08])
                BIXT [0x10] = DerefOf (PBIF [0x09])
                BIXT [0x11] = DerefOf (PBIF [0x0A])
                BIXT [0x12] = DerefOf (PBIF [0x0B])
                BIXT [0x13] = DerefOf (PBIF [0x0C])
                If ((DerefOf (BIXT [One]) == One))
                {
                    BIXT [One] = Zero
                    Local0 = DerefOf (BIXT [0x05])
                    BIXT [0x02] = (DerefOf (BIXT [0x02]) * Local0)
                    BIXT [0x03] = (DerefOf (BIXT [0x03]) * Local0)
                    BIXT [0x06] = (DerefOf (BIXT [0x06]) * Local0)
                    BIXT [0x07] = (DerefOf (BIXT [0x07]) * Local0)
                    BIXT [0x0E] = (DerefOf (BIXT [0x0E]) * Local0)
                    BIXT [0x0F] = (DerefOf (BIXT [0x0F]) * Local0)
                    Divide (DerefOf (BIXT [0x02]), 0x03E8, Local0, BIXT [0x02])
                    Divide (DerefOf (BIXT [0x03]), 0x03E8, Local0, BIXT [0x03])
                    Divide (DerefOf (BIXT [0x06]), 0x03E8, Local0, BIXT [0x06])
                    Divide (DerefOf (BIXT [0x07]), 0x03E8, Local0, BIXT [0x07])
                    Divide (DerefOf (BIXT [0x0E]), 0x03E8, Local0, BIXT [0x0E])
                    Divide (DerefOf (BIXT [0x0F]), 0x03E8, Local0, BIXT [0x0F])
                }

                BIXT [0x08] = B1B2(^^LPCB.EC0.B0CL, ^^LPCB.EC0.B0CH) /* \_SB_.PCI0.LPCB.EC0_.B0C3 */
                BIXT [0x09] = 0x0001869F
                Return (BIXT) /* \_SB_.PCI0.BAT0.BIXT */
                }

            Else
                {
                    Return (XBIX ())
                }
            }
    }
}

