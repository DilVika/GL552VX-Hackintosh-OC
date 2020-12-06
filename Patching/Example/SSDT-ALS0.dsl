/*
 * Starting with macOS 10.15 Ambient Light Sensor presence is required for backlight functioning.
 * Here we create an Ambient Light Sensor ACPI Device, which can be used by SMCLightSensor kext
 * to report either dummy (when no device is present) or valid values through SMC interface.
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "ALS0", 0x00000000)
{
    Scope (_SB)
    {
        Device (ALS0)
        {
            Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
            Name (_CID, "smc-als")  // _CID: Compatible ID
            Name (_ALI, 150)  // _ALI: Ambient Light Illuminance
            Name (_ALR, Package ()  // _ALR: Ambient Light Response
            {
                Package ()
                {
                    100,150
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
}

