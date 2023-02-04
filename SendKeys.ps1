$PSSendKey = Add-Type -MemberDefinition @'
const uint KEYEVENTF_EXTENDEDKEY = 0x0001;
const uint KEYEVENTF_KEYUP = 0x0002;

[DllImport("user32.dll")]
static extern void keybd_event(byte byVk, byte byScan, uint dwFlags, UIntPtr dwExtraInfo);

public static void KeyDown(uint vKey)
{
    keybd_event((byte) vKey, 0, KEYEVENTF_EXTENDEDKEY | 0, UIntPtr.Zero);
    // Thread.Sleep(10);
}

public static void KeyUp(uint vKey)
{
    keybd_event((byte) vKey, 0, KEYEVENTF_EXTENDEDKEY | KEYEVENTF_KEYUP, UIntPtr.Zero);
}
'@ -Name SendKey -UsingNamespace System.Threading -PassThru

Start-Sleep -Seconds 3

$PSSendKey::KeyDown(0x30)
$PSSendKey::KeyDown(0x31)
$PSSendKey::KeyDown(0x32)
$PSSendKey::KeyDown(0x33)
$PSSendKey::KeyDown(0x34)
$PSSendKey::KeyDown(0x35)
$PSSendKey::KeyDown(0x36)
$PSSendKey::KeyDown(0x37)
$PSSendKey::KeyDown(0x38)
$PSSendKey::KeyDown(0x39)
